package com.ewatts.auth2.service;

import com.ewatts.auth2.config.OAuthConfig;
import com.ewatts.auth2.dto.OAuthTokenResponse;
import com.ewatts.auth2.dto.OAuthUserInfo;
import com.ewatts.auth2.exception.BadRequestException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
@RequiredArgsConstructor
@Slf4j
public class GitHubOAuthService {

    private final OAuthConfig oAuthConfig;
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public String getAuthUrl(String state) {
        return UriComponentsBuilder
                .fromUriString("https://github.com/login/oauth/authorize")
                .queryParam("client_id", oAuthConfig.getGithub().getClientId())
                .queryParam("redirect_uri", oAuthConfig.getMobileRedirectUri() + "/github")
                .queryParam("scope", "user:email")
                .queryParam("state", state)
                .build()
                .toUriString();
    }

    public OAuthUserInfo getUserInfo(String code) {
        try {
            // Step 1: Exchange code for access token
            OAuthTokenResponse tokenResponse = getAccessToken(code);

            // Step 2: Get user info using access token
            return fetchUserInfo(tokenResponse.getAccessToken());

        } catch (Exception e) {
            log.error("Error getting GitHub user info: ", e);
            throw new BadRequestException("Failed to authenticate with GitHub: " + e.getMessage());
        }
    }

    private OAuthTokenResponse getAccessToken(String code) {
        String tokenUrl = "https://github.com/login/oauth/access_token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("Accept", "application/json");

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", oAuthConfig.getGithub().getClientId());
        params.add("client_secret", oAuthConfig.getGithub().getClientSecret());
        params.add("code", code);
        params.add("redirect_uri", oAuthConfig.getMobileRedirectUri() + "/github");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<String> response = restTemplate.postForEntity(tokenUrl, request, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JsonNode responseJson = objectMapper.readTree(response.getBody());

                if (responseJson.has("error")) {
                    throw new BadRequestException("GitHub OAuth error: " + responseJson.get("error_description").asText());
                }

                return new OAuthTokenResponse(
                        responseJson.get("access_token").asText(),
                        responseJson.get("token_type").asText(),
                        responseJson.has("scope") ? responseJson.get("scope").asText() : null,
                        responseJson.has("refresh_token") ? responseJson.get("refresh_token").asText() : null,
                        responseJson.has("expires_in") ? responseJson.get("expires_in").asLong() : null
                );
            } else {
                throw new BadRequestException("Failed to get access token from GitHub");
            }
        } catch (Exception e) {
            log.error("Error exchanging code for token: ", e);
            throw new BadRequestException("Failed to exchange authorization code for access token");
        }
    }

    private OAuthUserInfo fetchUserInfo(String accessToken) {
        String userUrl = "https://api.github.com/user";
        String emailUrl = "https://api.github.com/user/emails";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.set("Accept", "application/vnd.github.v3+json");

        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            // Get user basic info
            ResponseEntity<String> userResponse = restTemplate.exchange(userUrl, HttpMethod.GET, entity, String.class);
            JsonNode userJson = objectMapper.readTree(userResponse.getBody());

            // Get user emails
            ResponseEntity<String> emailResponse = restTemplate.exchange(emailUrl, HttpMethod.GET, entity, String.class);
            JsonNode emailsJson = objectMapper.readTree(emailResponse.getBody());

            // Find primary email
            String primaryEmail = null;
            boolean emailVerified = false;

            if (emailsJson.isArray()) {
                for (JsonNode emailNode : emailsJson) {
                    if (emailNode.get("primary").asBoolean()) {
                        primaryEmail = emailNode.get("email").asText();
                        emailVerified = emailNode.get("verified").asBoolean();
                        break;
                    }
                }
            }

            // If no primary email found, use the first one
            if (primaryEmail == null && emailsJson.isArray() && emailsJson.size() > 0) {
                JsonNode firstEmail = emailsJson.get(0);
                primaryEmail = firstEmail.get("email").asText();
                emailVerified = firstEmail.get("verified").asBoolean();
            }

            return new OAuthUserInfo(
                    userJson.get("id").asText(),
                    primaryEmail,
                    userJson.get("login").asText(),
                    userJson.has("name") && !userJson.get("name").isNull() ? userJson.get("name").asText() : userJson.get("login").asText(),
                    userJson.has("avatar_url") && !userJson.get("avatar_url").isNull() ? userJson.get("avatar_url").asText() : null,
                    null, // GitHub doesn't provide phone numbers
                    emailVerified
            );

        } catch (Exception e) {
            log.error("Error fetching GitHub user info: ", e);
            throw new BadRequestException("Failed to fetch user information from GitHub");
        }
    }
}
