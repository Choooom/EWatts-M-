package com.ewatts.auth2.security;

import com.ewatts.auth2.service.RefreshTokenService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JwtUtils jwtUtils;
    private final RefreshTokenService refreshTokenService;

    @Value("${app.oauth2.authorized-redirect-uris:http://localhost:3000/oauth2/redirect}")
    private String[] authorizedRedirectUris;

    @PostConstruct
    public void init() {
        setDefaultTargetUrl(authorizedRedirectUris.length > 0
                ? authorizedRedirectUris[0]
                : "http://localhost:3000/oauth2/redirect");
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String token = jwtUtils.generateJwtToken(authentication);
        UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
        String refreshToken = refreshTokenService.createRefreshToken(userPrincipal.getId()).getToken();

        String acceptHeader = request.getHeader("Accept");

        // ✅ If mobile app or API client
        if (acceptHeader != null && acceptHeader.contains("application/json")) {
            log.info("OAuth2 success for API/mobile client");
            response.setContentType("application/json");
            response.getWriter().write(String.format("{\"token\":\"%s\", \"refreshToken\":\"%s\"}", token, refreshToken));
            return;
        }

        // ✅ If browser-based frontend
        String targetUrl = UriComponentsBuilder.fromUriString(getDefaultTargetUrl())
                .queryParam("token", token)
                .queryParam("refreshToken", refreshToken)
                .build().toUriString();

        log.info("OAuth2 success for browser redirect: {}", targetUrl);
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        String targetUrl = super.getDefaultTargetUrl(); // call final method safely

        String token = jwtUtils.generateJwtToken(authentication);
        UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
        String refreshToken = refreshTokenService.createRefreshToken(userPrincipal.getId()).getToken();

        return UriComponentsBuilder.fromUriString(targetUrl)
                .queryParam("token", token)
                .queryParam("refreshToken", refreshToken)
                .build().toUriString();
    }
}

