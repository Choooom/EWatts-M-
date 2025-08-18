package com.ewatts.auth2.dto;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import jakarta.validation.constraints.NotBlank;

// OAuth Login Request
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OAuthLoginRequest {
    @NotBlank(message = "Authorization code is required")
    private String code;

    @NotBlank(message = "Provider is required")
    private String provider; // "github" or "discord"

    private String redirectUri;
}
