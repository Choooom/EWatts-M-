package com.ewatts.auth2.dto;

import java.util.Map;

public class DiscordOAuth2UserInfo extends OAuth2UserInfo {

    public DiscordOAuth2UserInfo(Map<String, Object> attributes) {
        super(attributes);
    }

    @Override
    public String getId() {
        return (String) attributes.get("id");
    }

    @Override
    public String getName() {
        return (String) attributes.get("username");
    }

    @Override
    public String getEmail() {
        return (String) attributes.get("email");
    }

    @Override
    public String getImageUrl() {
        String avatar = (String) attributes.get("avatar");
        String id = getId();
        if (avatar != null && id != null) {
            return String.format("https://cdn.discordapp.com/avatars/%s/%s.png", id, avatar);
        }
        return null;
    }
}
