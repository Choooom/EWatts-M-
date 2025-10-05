package com.ewatts.auth2.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@Getter
public class OAuthConfig {

    @Value("${oauth2.mobile-redirect-uri:https://districts-saves-commitments-pending.trycloudflare.com/api/oauth/callback}")
    private String mobileRedirectUri;

    // GitHub configuration
    @Value("${oauth2.github.client-id:}")
    private String githubClientId;

    @Value("${oauth2.github.client-secret:}")
    private String githubClientSecret;

    // Discord configuration
    @Value("${oauth2.discord.client-id:}")
    private String discordClientId;

    @Value("${oauth2.discord.client-secret:}")
    private String discordClientSecret;

    // Convenience methods to match the original API
    public Provider getGithub() {
        Provider provider = new Provider();
        provider.setClientId(githubClientId);
        provider.setClientSecret(githubClientSecret);
        provider.setAuthUrl("https://github.com/login/oauth/authorize");
        provider.setTokenUrl("https://github.com/login/oauth/access_token");
        provider.setUserInfoUrl("https://api.github.com/user");
        provider.setScope("user:email");
        return provider;
    }

    public Provider getDiscord() {
        Provider provider = new Provider();
        provider.setClientId(discordClientId);
        provider.setClientSecret(discordClientSecret);
        provider.setAuthUrl("https://discord.com/api/oauth2/authorize");
        provider.setTokenUrl("https://discord.com/api/oauth2/token");
        provider.setUserInfoUrl("https://discord.com/api/users/@me");
        provider.setScope("identify email");
        return provider;
    }

    @Getter
    public static class Provider {
        private String clientId;
        private String clientSecret;
        private String authUrl;
        private String tokenUrl;
        private String userInfoUrl;
        private String scope;

        public void setClientId(String clientId) {
            this.clientId = clientId;
        }

        public void setClientSecret(String clientSecret) {
            this.clientSecret = clientSecret;
        }

        public void setAuthUrl(String authUrl) {
            this.authUrl = authUrl;
        }

        public void setTokenUrl(String tokenUrl) {
            this.tokenUrl = tokenUrl;
        }

        public void setUserInfoUrl(String userInfoUrl) {
            this.userInfoUrl = userInfoUrl;
        }

        public void setScope(String scope) {
            this.scope = scope;
        }
    }
}