package com.ewatts.auth2.dto;

import com.ewatts.auth2.entity.AuthProvider;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminUserDto {
    private Long id;
    private String role;
    private String username;
    private String email;
    private String phoneNumber;
    private boolean emailVerified;
    private boolean accountEnabled;
    private AuthProvider provider;
    private String providerId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String profilePictureUrl;
    private int deviceCount;
}
