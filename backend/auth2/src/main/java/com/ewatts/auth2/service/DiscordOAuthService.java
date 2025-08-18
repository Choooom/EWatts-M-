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
public class DiscordOAuthService {

    private final OAuthConfig oAuthConfig;
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();


    public String getAuthUrl(String state) {
        return UriComponentsBuilder
                .fromUriString("https://discord.com/api/oauth2/authorize")
                .queryParam("client_id", oAuthConfig.getDiscord().getClientId())
                .queryParam("redirect_uri", oAuthConfig.getMobileRedirectUri() + "/discord")
                .queryParam("response_type", "code")
                .queryParam("scope", "identify email")
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
            log.error("Error getting Discord user info: ", e);
            throw new BadRequestException("Failed to authenticate with Discord: " + e.getMessage());
        }
    }

    private OAuthTokenResponse getAccessToken(String code) {
        String tokenUrl = "https://discord.com/api/oauth2/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", oAuthConfig.getDiscord().getClientId());
        params.add("client_secret", oAuthConfig.getDiscord().getClientSecret());
        params.add("grant_type", "authorization_code");
        params.add("code", code);
        params.add("redirect_uri", oAuthConfig.getMobileRedirectUri() + "/discord");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<String> response = restTemplate.postForEntity(tokenUrl, request, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JsonNode responseJson = objectMapper.readTree(response.getBody());

                if (responseJson.has("error")) {
                    throw new BadRequestException("Discord OAuth error: " + responseJson.get("error_description").asText());
                }

                return new OAuthTokenResponse(
                        responseJson.get("access_token").asText(),
                        responseJson.get("token_type").asText(),
                        responseJson.has("scope") ? responseJson.get("scope").asText() : null,
                        responseJson.has("refresh_token") ? responseJson.get("refresh_token").asText() : null,
                        responseJson.has("expires_in") ? responseJson.get("expires_in").asLong() : null
                );
            } else {
                throw new BadRequestException("Failed to get access token from Discord");
            }
        } catch (Exception e) {
            log.error("Error exchanging code for token: ", e);
            throw new BadRequestException("Failed to exchange authorization code for access token");
        }
    }

    private OAuthUserInfo fetchUserInfo(String accessToken) {
        String userUrl = "https://discord.com/api/users/@me";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(userUrl, HttpMethod.GET, entity, String.class);
            JsonNode userJson = objectMapper.readTree(response.getBody());

            // Build profile picture URL if avatar exists
            String profilePictureUrl = null;
            if (userJson.has("avatar") && !userJson.get("avatar").isNull()) {
                String avatarHash = userJson.get("avatar").asText();
                String userId = userJson.get("id").asText();
                profilePictureUrl = String.format("https://cdn.discordapp.com/avatars/%s/%s.png?size=256", userId, avatarHash);
            }

            // Discord provides global_name (display name) and username
            String displayName = userJson.has("global_name") && !userJson.get("global_name").isNull()
                    ? userJson.get("global_name").asText()
                    : userJson.get("username").asText();

            return new OAuthUserInfo(
                    userJson.get("id").asText(),
                    userJson.has("email") && !userJson.get("email").isNull() ? userJson.get("email").asText() : null,
                    userJson.get("username").asText(),
                    displayName,
                    profilePictureUrl,
                    null, // Discord doesn't provide phone numbers
                    userJson.has("verified") ? userJson.get("verified").asBoolean() : false
            );

        } catch (Exception e) {
            log.error("Error fetching Discord user info: ", e);
            throw new BadRequestException("Failed to fetch user information from Discord");
        }
    }
}
