package com.ewatts.auth2.service;

import com.ewatts.auth2.dto.*;
import com.ewatts.auth2.entity.AuthProvider;
import com.ewatts.auth2.entity.OtpToken;
import com.ewatts.auth2.entity.OtpType;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.exception.BadRequestException;
import com.ewatts.auth2.exception.ResourceNotFoundException;
import com.ewatts.auth2.repository.OtpTokenRepository;
import com.ewatts.auth2.repository.UserRepository;
import com.ewatts.auth2.security.JwtUtils;
import com.ewatts.auth2.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class AuthService {

    private final UserRepository userRepository;
    private final OtpTokenRepository otpTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtUtils jwtUtils;
    private final EmailService emailService;
    private final OtpService otpService;
    private final RefreshTokenService refreshTokenService;

    public JwtResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getUsernameOrEmail(), loginRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();

        if (!userPrincipal.isEmailVerified()) {
            throw new BadRequestException("Please verify your email address before logging in.");
        }

        String jwt = jwtUtils.generateJwtToken(authentication);
        String refreshToken = refreshTokenService.createRefreshToken(userPrincipal.getId()).getToken();

        User user = userRepository.findById(userPrincipal.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userPrincipal.getId()));

        UserDto userDto = convertToUserDto(user);

        return new JwtResponse(jwt, refreshToken, (long) jwtUtils.getJwtExpirationMs(), userDto);
    }

    public ApiResponse signUp(SignUpRequest signUpRequest) {
        // Check if username exists

        if (userRepository.existsByUsername(signUpRequest.getUsername())) {
            throw new BadRequestException("Username is already taken!");
        }

        // Check if email exists
        if (userRepository.existsByEmail(signUpRequest.getEmail())) {
            throw new BadRequestException("Email address is already in use!");
        }

        // Check if phone number exists (if provided)
        if (signUpRequest.getPhoneNumber() != null && !signUpRequest.getPhoneNumber().isEmpty()) {
            if (userRepository.existsByPhoneNumber(signUpRequest.getPhoneNumber())) {
                throw new BadRequestException("Phone number is already in use!");
            }
        }

        // Generate and send OTP for email verification
        String otpCode = otpService.generateOtp();
        OtpToken otpToken = new OtpToken();
        otpToken.setEmail(signUpRequest.getEmail());
        otpToken.setOtpCode(otpCode);
        otpToken.setType(OtpType.EMAIL_VERIFICATION);
        otpToken.setExpiresAt(LocalDateTime.now().plusMinutes(5));

        otpTokenRepository.save(otpToken);

        // Store user data temporarily in OTP token (you might want to use a different approach)
        emailService.sendVerificationEmail(signUpRequest.getEmail(), otpCode, signUpRequest.getUsername());

        return new ApiResponse(true, "Registration initiated! Please check your email for verification code.", null);
    }

    public ApiResponse resendOtp(ResendOtpRequest request) {
        // Check if email was used in signup
        Optional<OtpToken> existingOtp = otpTokenRepository.findTopByEmailAndTypeOrderByCreatedAtDesc(
                request.getEmail(), OtpType.EMAIL_VERIFICATION
        );

        if (existingOtp.isEmpty()) {
            throw new BadRequestException("Please sign up first.");
        }

        // Invalidate old OTP
        OtpToken otpToken = existingOtp.get();
        otpToken.setUsed(true);
        otpTokenRepository.save(otpToken);

        // Generate new OTP
        String newOtpCode = otpService.generateOtp();
        OtpToken newOtp = new OtpToken();
        newOtp.setEmail(request.getEmail());
        newOtp.setOtpCode(newOtpCode);
        newOtp.setType(OtpType.EMAIL_VERIFICATION);
        newOtp.setExpiresAt(LocalDateTime.now().plusMinutes(5));

        otpTokenRepository.save(newOtp);

        // Send email
        emailService.sendVerificationEmail(request.getEmail(), newOtpCode, null);

        return new ApiResponse(true, "A new OTP has been sent to your email.", null);
    }




    public JwtResponse verifyEmailAndCompleteSignup(EmailVerificationRequest request, SignUpRequest signUpRequest) {
        // Validate OTP - Fixed: Changed from PASSWORD_RESET to EMAIL_VERIFICATION
        OtpToken otpToken = otpTokenRepository.findByEmailAndOtpCodeAndTypeAndUsedFalseAndExpiresAtAfter(
                        request.getEmail(), request.getOtpCode(), OtpType.EMAIL_VERIFICATION, LocalDateTime.now())
                .orElseThrow(() -> new BadRequestException("Invalid or expired OTP code"));

        // Mark OTP as used
        otpToken.setUsed(true);
        otpTokenRepository.save(otpToken);

        // Create new user (not update existing) - Fixed: This is signup completion, not password reset
        User user = new User();
        user.setUsername(signUpRequest.getUsername());
        user.setEmail(signUpRequest.getEmail());
        user.setPhoneNumber(signUpRequest.getPhoneNumber());
        user.setPassword(passwordEncoder.encode(signUpRequest.getPassword()));
        user.setEmailVerified(true); // Mark as verified since they completed email verification
        user.setProvider(AuthProvider.valueOf(signUpRequest.getProvider() != null ? signUpRequest.getProvider() : "LOCAL"));
        user.setCreatedAt(LocalDateTime.now());

        User savedUser = userRepository.save(user);

        // Generate JWT token for immediate login
        Authentication authentication = new UsernamePasswordAuthenticationToken(
                savedUser.getUsername(), null, null);

        String jwt = jwtUtils.generateTokenFromUsername(savedUser.getUsername());
        String refreshToken = refreshTokenService.createRefreshToken(savedUser.getId()).getToken();

        UserDto userDto = convertToUserDto(savedUser);

        return new JwtResponse(jwt, refreshToken, (long) jwtUtils.getJwtExpirationMs(), userDto);
    }

    public JwtResponse refreshToken(RefreshTokenRequest request) {
        return refreshTokenService.findByToken(request.getRefreshToken())
                .map(refreshTokenService::verifyExpiration)
                .map(refreshToken -> {
                    String token = jwtUtils.generateTokenFromUsername(refreshToken.getUser().getUsername());
                    UserDto userDto = convertToUserDto(refreshToken.getUser());
                    return new JwtResponse(token, refreshToken.getToken(), (long) jwtUtils.getJwtExpirationMs(), userDto);
                })
                .orElseThrow(() -> new BadRequestException("Refresh token is not in database!"));
    }

    public ApiResponse forgotPassword(ForgotPasswordRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User", "email", request.getEmail()));

        // Generate OTP for password reset
        String otpCode = otpService.generateOtp();
        OtpToken otpToken = new OtpToken();
        otpToken.setEmail(user.getEmail());
        otpToken.setOtpCode(otpCode);
        otpToken.setType(OtpType.PASSWORD_RESET);
        otpToken.setExpiresAt(LocalDateTime.now().plusMinutes(5));

        otpTokenRepository.save(otpToken);

        // Send reset email
        emailService.sendPasswordResetEmail(user.getEmail(), otpCode, user.getUsername());

        return new ApiResponse(true, "Password reset OTP sent to your email.", null);
    }

    public ApiResponse resetPassword(ResetPasswordRequest request) {
        OtpToken otpToken = otpTokenRepository.findByEmailAndOtpCodeAndTypeAndUsedFalseAndExpiresAtAfter(
                        request.getEmail(), request.getOtpCode(), OtpType.PASSWORD_RESET, LocalDateTime.now())
                .orElseThrow(() -> new BadRequestException("Invalid or expired OTP code"));

        otpToken.setUsed(true);
        otpTokenRepository.save(otpToken);

        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User", "email", request.getEmail()));

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);

        return new ApiResponse(true, "Password has been reset successfully.", null);
    }

    public ApiResponse verifyPasswordResetOtp(VerifyOtpRequest request) {
        // Validate OTP
        OtpToken otpToken = otpTokenRepository.findByEmailAndOtpCodeAndTypeAndUsedFalseAndExpiresAtAfter(
                        request.getEmail(),
                        request.getOtpCode(),
                        OtpType.PASSWORD_RESET,
                        LocalDateTime.now()
                )
                .orElseThrow(() -> new BadRequestException("Invalid or expired OTP code"));

        // Mark OTP as used
        otpToken.setUsed(true);
        otpTokenRepository.save(otpToken);

        // Optionally, create a short-lived reset token (UUID)
        String resetToken = UUID.randomUUID().toString();
        otpService.storeResetToken(request.getEmail(), resetToken); // You implement storage logic

        return new ApiResponse(true, "OTP verified successfully. Proceed to reset your password.", resetToken);
    }

    public ApiResponse setNewPassword(SetNewPasswordRequest request) {
        // Check the reset token is valid
        if (!otpService.isValidResetToken(request.getEmail(), request.getResetToken())) {
            throw new BadRequestException("Invalid or expired reset token.");
        }

        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new BadRequestException("Passwords do not match");
        }

        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User", "email", request.getEmail()));

        // Update password
        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);

        // Invalidate reset token
        otpService.invalidateResetToken(request.getEmail());

        return new ApiResponse(true, "Password has been reset successfully.", null);
    }


    @Transactional
    public User updateProfilePicture(Long userId, String profilePictureUrl) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "user profile", userId));
        user.setProfilePictureUrl(profilePictureUrl);
        return userRepository.save(user);
    }

    public void logout(String refreshToken) {
        refreshTokenService.deleteByToken(refreshToken);
    }


    private UserDto convertToUserDto(User user) {
        UserDto userDto = new UserDto();
        userDto.setId(user.getId());
        userDto.setUsername(user.getUsername());
        userDto.setEmail(user.getEmail());
        userDto.setPhoneNumber(user.getPhoneNumber());
        userDto.setEmailVerified(user.isEmailVerified());
        userDto.setProvider(user.getProvider());
        userDto.setCreatedAt(user.getCreatedAt());
        return userDto;
    }
}
