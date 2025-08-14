package com.ewatts.auth2.dto;

import com.ewatts.auth2.entity.AuthProvider;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
    private Long id;
    private String username;
    private String email;
    private String phoneNumber;
    private boolean emailVerified;
    private AuthProvider provider;
    private LocalDateTime createdAt;
    private String profilePictureUrl;
}

