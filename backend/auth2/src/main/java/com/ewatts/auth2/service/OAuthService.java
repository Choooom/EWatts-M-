package com.ewatts.auth2.service;

import com.ewatts.auth2.config.OAuthConfig;
import com.ewatts.auth2.dto.*;
import com.ewatts.auth2.entity.AuthProvider;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.exception.BadRequestException;
import com.ewatts.auth2.repository.UserRepository;
import com.ewatts.auth2.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class OAuthService {

    private final UserRepository userRepository;
    private final JwtUtils jwtUtils;
    private final RefreshTokenService refreshTokenService;
    private final GitHubOAuthService gitHubOAuthService;
    private final DiscordOAuthService discordOAuthService;
    private final OAuthConfig oAuthConfig;

    public OAuthAuthUrlResponse getAuthUrl(String provider) {
        log.info("Getting OAuth URL for provider: {}", provider);

        // Debug configuration
        log.info("Mobile redirect URI: {}", oAuthConfig.getMobileRedirectUri());
        log.info("GitHub client ID: {}", oAuthConfig.getGithub().getClientId());
        log.info("Discord client ID: {}", oAuthConfig.getDiscord().getClientId());

        // Check if configuration is loaded
        if (oAuthConfig.getMobileRedirectUri() == null || oAuthConfig.getMobileRedirectUri().isEmpty()) {
            log.error("Mobile redirect URI is not configured");
            throw new BadRequestException("OAuth configuration is missing: mobile redirect URI");
        }

        String state = UUID.randomUUID().toString();
        String authUrl;

        try {
            switch (provider.toLowerCase()) {
                case "github":
                    if (oAuthConfig.getGithub().getClientId() == null || oAuthConfig.getGithub().getClientId().isEmpty()) {
                        throw new BadRequestException("GitHub client ID is not configured");
                    }
                    authUrl = gitHubOAuthService.getAuthUrl(state);
                    break;
                case "discord":
                    if (oAuthConfig.getDiscord().getClientId() == null || oAuthConfig.getDiscord().getClientId().isEmpty()) {
                        throw new BadRequestException("Discord client ID is not configured");
                    }
                    authUrl = discordOAuthService.getAuthUrl(state);
                    break;
                default:
                    throw new BadRequestException("Unsupported OAuth provider: " + provider);
            }

            log.info("Generated OAuth URL for {}: {}", provider, authUrl);
            return new OAuthAuthUrlResponse(authUrl, state);

        } catch (Exception e) {
            log.error("Error generating OAuth URL for provider {}: ", provider, e);
            throw new BadRequestException("Failed to generate OAuth URL: " + e.getMessage());
        }
    }

    public JwtResponse authenticateWithOAuth(OAuthLoginRequest request) {
        log.info("Processing OAuth login for provider: {}", request.getProvider());

        // Get user info from OAuth provider
        OAuthUserInfo userInfo = getUserInfoFromProvider(request);

        if (userInfo == null || userInfo.getEmail() == null) {
            throw new BadRequestException("Failed to retrieve user information from OAuth provider");
        }

        // Find or create user
        User user = findOrCreateUser(userInfo, request.getProvider());

        // Generate JWT tokens
        String jwt = jwtUtils.generateTokenFromUsername(user.getUsername());
        String refreshToken = refreshTokenService.createRefreshToken(user.getId()).getToken();

        UserDto userDto = convertToUserDto(user);

        log.info("OAuth login successful for user: {}", user.getEmail());
        return new JwtResponse(jwt, refreshToken, (long) jwtUtils.getJwtExpirationMs(), userDto);
    }

    private OAuthUserInfo getUserInfoFromProvider(OAuthLoginRequest request) {
        switch (request.getProvider().toLowerCase()) {
            case "github":
                return gitHubOAuthService.getUserInfo(request.getCode());
            case "discord":
                return discordOAuthService.getUserInfo(request.getCode());
            default:
                throw new BadRequestException("Unsupported OAuth provider: " + request.getProvider());
        }
    }

    private User findOrCreateUser(OAuthUserInfo userInfo, String providerName) {
        AuthProvider provider = AuthProvider.valueOf(providerName.toUpperCase());

        // First, try to find user by provider and provider ID
        Optional<User> existingUser = userRepository.findByProviderAndProviderId(provider, userInfo.getId());

        if (existingUser.isPresent()) {
            // Update user info if needed
            User user = existingUser.get();
            updateUserFromOAuthInfo(user, userInfo);
            return userRepository.save(user);
        }

        // Check if user with same email exists but different provider
        Optional<User> userByEmail = userRepository.findByEmail(userInfo.getEmail());
        if (userByEmail.isPresent()) {
            User user = userByEmail.get();
            // Link this OAuth provider to existing account
            if (user.getProvider() == AuthProvider.LOCAL) {
                user.setProvider(provider);
                user.setProviderId(userInfo.getId());
                updateUserFromOAuthInfo(user, userInfo);
                return userRepository.save(user);
            } else {
                throw new BadRequestException("Email is already registered with a different OAuth provider");
            }
        }

        // Create new user
        return createNewOAuthUser(userInfo, provider);
    }

    private User createNewOAuthUser(OAuthUserInfo userInfo, AuthProvider provider) {
        User user = new User();
        user.setEmail(userInfo.getEmail());
        user.setUsername(generateUniqueUsername(userInfo.getUsername()));
        user.setProvider(provider);
        user.setProviderId(userInfo.getId());
        user.setEmailVerified(userInfo.getEmailVerified() != null ? userInfo.getEmailVerified() : true);
        user.setAccountEnabled(true);
        user.setProfilePictureUrl(userInfo.getProfilePictureUrl());
        user.setPhoneNumber(userInfo.getPhoneNumber());
        user.setPassword(""); // OAuth users don't have passwords
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());

        log.info("Creating new OAuth user with email: {}", userInfo.getEmail());
        return userRepository.save(user);
    }

    private void updateUserFromOAuthInfo(User user, OAuthUserInfo userInfo) {
        // Update profile picture if provided
        if (userInfo.getProfilePictureUrl() != null && !userInfo.getProfilePictureUrl().isEmpty()) {
            user.setProfilePictureUrl(userInfo.getProfilePictureUrl());
        }

        // Update phone number if provided and not already set
        if (user.getPhoneNumber() == null && userInfo.getPhoneNumber() != null) {
            user.setPhoneNumber(userInfo.getPhoneNumber());
        }

        user.setUpdatedAt(LocalDateTime.now());
    }

    private String generateUniqueUsername(String baseUsername) {
        if (baseUsername == null || baseUsername.trim().isEmpty()) {
            baseUsername = "user";
        }

        String username = baseUsername.toLowerCase().replaceAll("[^a-z0-9_]", "");
        if (username.length() > 20) {
            username = username.substring(0, 20);
        }

        String originalUsername = username;
        int counter = 1;

        while (userRepository.existsByUsername(username)) {
            username = originalUsername + counter;
            counter++;
        }

        return username;
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
        userDto.setProfilePictureUrl(user.getProfilePictureUrl());
        return userDto;
    }
}
