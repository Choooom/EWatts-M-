package com.ewatts.auth2.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OAuthAuthUrlResponse {
    private String authUrl;
    private String state;
}
