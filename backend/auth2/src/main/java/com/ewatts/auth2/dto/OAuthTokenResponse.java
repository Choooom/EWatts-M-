package com.ewatts.auth2.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OAuthTokenResponse {
    private String accessToken;
    private String tokenType;
    private String scope;
    private String refreshToken;
    private Long expiresIn;
}
