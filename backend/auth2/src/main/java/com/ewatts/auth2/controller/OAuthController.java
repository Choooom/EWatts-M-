package com.ewatts.auth2.controller;

import com.ewatts.auth2.config.OAuthConfig;
import com.ewatts.auth2.dto.JwtResponse;
import com.ewatts.auth2.dto.OAuthAuthUrlResponse;
import com.ewatts.auth2.dto.OAuthLoginRequest;
import com.ewatts.auth2.service.OAuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth/oauth")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*", maxAge = 3600)
public class OAuthController {

    private final OAuthService oAuthService;
    private final OAuthConfig oAuthConfig;

    /**
     * Get OAuth authorization URL for mobile app
     * Mobile app will use this URL to open OAuth provider login
     */
    @GetMapping("/{provider}/url")
    public ResponseEntity<OAuthAuthUrlResponse> getAuthUrl(@PathVariable String provider) {
        log.info("Generating OAuth URL for provider: {}", provider);
        OAuthAuthUrlResponse response = oAuthService.getAuthUrl(provider);
        return ResponseEntity.ok(response);
    }

    /**
     * Complete OAuth login after mobile app receives authorization code
     * This is called when the OAuth provider redirects back with the code
     */
    @PostMapping("/login")
    public ResponseEntity<JwtResponse> oAuthLogin(@Valid @RequestBody OAuthLoginRequest request) {
        log.info("Processing OAuth login for provider: {}", request.getProvider());
        JwtResponse response = oAuthService.authenticateWithOAuth(request);
        return ResponseEntity.ok(response);
    }

    /**
     * Handle OAuth callback - redirect back to mobile app with tokens
     * This is called by OAuth providers after user authorization
     */
    @GetMapping("/callback/{provider}")
    public RedirectView handleCallback(
            @PathVariable String provider,
            @RequestParam(required = false) String code,
            @RequestParam(required = false) String error,
            @RequestParam(required = false) String state) {

        log.info("OAuth callback received for provider: {}", provider);

        // Handle OAuth errors
        if (error != null) {
            log.error("OAuth callback error for {}: {}", provider, error);
            return new RedirectView("ewatts://oauth/callback?error=" + error);
        }

        // Handle missing authorization code
        if (code == null) {
            log.error("No authorization code provided in callback");
            return new RedirectView("ewatts://oauth/callback?error=no_code");
        }

        try {
            // Process OAuth login using the authorization code
            OAuthLoginRequest loginRequest = new OAuthLoginRequest(code, provider, null);
            JwtResponse jwtResponse = oAuthService.authenticateWithOAuth(loginRequest);

            // Redirect back to mobile app with tokens
            String redirectUrl = String.format(
                    "ewatts://oauth/callback?success=true&access_token=%s&refresh_token=%s&expires_in=%d",
                    jwtResponse.getAccessToken(),
                    jwtResponse.getRefreshToken(),
                    jwtResponse.getExpiresIn()
            );

            log.info("OAuth login successful, redirecting to mobile app " + redirectUrl );
            return new RedirectView(redirectUrl);

        } catch (Exception e) {
            log.error("Error processing OAuth callback for {}: ", provider, e);
            return new RedirectView("ewatts://oauth/callback?error=authentication_failed");
        }
    }

    /**
     * Fallback callback handler without provider in URL
     * Attempts to detect provider from state or other parameters
     */
    @GetMapping("/callback")
    public RedirectView handleCallbackFallback(
            @RequestParam(required = false) String code,
            @RequestParam(required = false) String error,
            @RequestParam(required = false) String state) {

        log.info("OAuth callback received without provider specification");

        // Handle OAuth errors
        if (error != null) {
            log.error("OAuth callback error: {}", error);
            return new RedirectView("ewatts://oauth/callback?error=" + error);
        }

        // Handle missing authorization code
        if (code == null) {
            log.error("No authorization code provided in callback");
            return new RedirectView("ewatts://oauth/callback?error=no_code");
        }

        // Try to determine provider from the state parameter or other means
        // This is a fallback - it's better to use the provider-specific endpoint
        String provider = determineProviderFromCallback(state, code);

        if (provider == null) {
            log.error("Could not determine OAuth provider");
            return new RedirectView("ewatts://oauth/callback?error=unknown_provider");
        }

        // Forward to the provider-specific handler
        return handleCallback(provider, code, error, state);
    }

    private String determineProviderFromCallback(String state, String code) {
        // Try to determine provider from state parameter if it contains provider info
        // Or you could make additional API calls to determine the provider
        // For now, we'll assume discord since that's what you're testing
        // In production, you should store the provider in the state parameter

        if (state != null) {
            // If you encode provider info in state, decode it here
            // For example, if state is "discord:uuid", extract "discord"
        }

        // Fallback - you might want to make this more robust
        log.warn("Using fallback provider detection - consider using provider-specific URLs");
        return "discord"; // Default assumption for now
    }

    /**
     * Debug endpoint to check OAuth configuration
     */
    @GetMapping("/debug/config")
    public ResponseEntity<Map<String, Object>> debugConfig() {
        Map<String, Object> config = new HashMap<>();
        config.put("githubClientId", oAuthConfig.getGithub().getClientId());
        config.put("discordClientId", oAuthConfig.getDiscord().getClientId());
        config.put("redirectUri", oAuthConfig.getMobileRedirectUri());
        return ResponseEntity.ok(config);
    }
}