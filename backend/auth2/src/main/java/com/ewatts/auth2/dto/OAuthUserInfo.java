package com.ewatts.auth2.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OAuthUserInfo {
    private String id;
    private String email;
    private String username;
    private String displayName;
    private String profilePictureUrl;
    private String phoneNumber;
    private Boolean emailVerified;
}
