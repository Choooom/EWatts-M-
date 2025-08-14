package com.ewatts.auth2.controller;

import com.ewatts.auth2.dto.*;
import com.ewatts.auth2.service.AuthService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*", maxAge = 3600)
public class AuthController {

    private final AuthService authService;

    // Temporary storage for signup data (in production, use Redis or database)
    private final Map<String, SignUpRequest> pendingSignups = new ConcurrentHashMap<>();

    @PostMapping("/signup")
    public ResponseEntity<ApiResponse> signUp(@Valid @RequestBody SignUpRequest signUpRequest) {
        log.info("Signup request received for email: {}", signUpRequest.getEmail());

        // Store signup data temporarily
        pendingSignups.put(signUpRequest.getEmail(), signUpRequest);

        ApiResponse response = authService.signUp(signUpRequest);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/verify-email")
    public ResponseEntity<JwtResponse> verifyEmail(@Valid @RequestBody EmailVerificationRequest request) {
        log.info("Email verification request received for email: {}", request.getEmail());

        // Retrieve pending signup data
        SignUpRequest signUpRequest = pendingSignups.get(request.getEmail());
        if (signUpRequest == null) {
            return ResponseEntity.badRequest()
                    .body(new JwtResponse(null, null, 0L, null));
        }

        JwtResponse response = authService.verifyEmailAndCompleteSignup(request, signUpRequest);

        // Remove from pending signups
        pendingSignups.remove(request.getEmail());

        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<JwtResponse> login(@Valid @RequestBody LoginRequest loginRequest) {
        log.info("Login request received for user: {}", loginRequest.getUsernameOrEmail());
        JwtResponse response = authService.login(loginRequest);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<ApiResponse> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request) {
        log.info("Forgot password request received for email: {}", request.getEmail());
        ApiResponse response = authService.forgotPassword(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/reset-password")
    public ResponseEntity<ApiResponse> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
        log.info("Reset password request received for email: {}", request.getEmail());
        ApiResponse response = authService.resetPassword(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/refresh-token")
    public ResponseEntity<JwtResponse> refreshToken(@Valid @RequestBody RefreshTokenRequest request) {
        log.info("Refresh token request received");
        JwtResponse response = authService.refreshToken(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/oauth2/redirect")
    public ResponseEntity<String> oauth2RedirectHandler(HttpServletRequest request) {
        String token = request.getParameter("token");
        String refreshToken = request.getParameter("refreshToken");
        String error = request.getParameter("error");

        if (token != null && refreshToken != null) {
            return ResponseEntity.ok(String.format(
                    "OAuth2 login successful! Token: %s, Refresh Token: %s", token, refreshToken));
        } else if (error != null) {
            return ResponseEntity.badRequest().body("OAuth2 login failed: " + error);
        } else {
            return ResponseEntity.badRequest().body("Invalid OAuth2 redirect");
        }
    }
}

