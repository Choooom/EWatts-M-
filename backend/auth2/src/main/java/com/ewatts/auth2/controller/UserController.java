package com.ewatts.auth2.controller;

import com.ewatts.auth2.dto.ApiResponse;
import com.ewatts.auth2.dto.UserDto;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.repository.UserRepository;
import com.ewatts.auth2.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth/user")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*", maxAge = 3600)
public class UserController {

    private final UserRepository userRepository;

    @GetMapping("/profile")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse> getUserProfile(@AuthenticationPrincipal UserPrincipal userPrincipal) {
        log.info("Get profile request for user: {}", userPrincipal.getUsername());

        User user = userRepository.findById(userPrincipal.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        UserDto userDto = convertToUserDto(user);
        ApiResponse response = new ApiResponse(true, "User profile retrieved successfully", userDto);

        return ResponseEntity.ok(response);
    }

    @PutMapping("/profile-picture")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse> updateProfilePicture(
            @AuthenticationPrincipal UserPrincipal userPrincipal,
            @RequestParam String profilePictureUrl) {

        log.info("Updating profile picture for user: {}", userPrincipal.getUsername());

        User user = userRepository.findById(userPrincipal.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        user.setProfilePictureUrl(profilePictureUrl);
        userRepository.save(user);

        UserDto userDto = convertToUserDto(user);
        ApiResponse response = new ApiResponse(true, "Profile picture updated successfully", userDto);

        return ResponseEntity.ok(response);
    }


    @GetMapping("/test")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse> testAuth(@AuthenticationPrincipal UserPrincipal userPrincipal) {
        log.info("Test auth request for user: {}", userPrincipal.getUsername());
        ApiResponse response = new ApiResponse(true,
                "Authentication successful! Welcome " + userPrincipal.getUsername());
        return ResponseEntity.ok(response);
    }

    private UserDto convertToUserDto(User user) {
        UserDto userDto = new UserDto();
        userDto.setId(user.getId());
        userDto.setUsername(user.getUsername());
        userDto.setEmail(user.getEmail());
        userDto.setPhoneNumber(user.getPhoneNumber());
        userDto.setEmailVerified(user.isEmailVerified());
        userDto.setProvider(user.getProvider());
        userDto.setCreatedAt(user.getCreatedAt());
        userDto.setProfilePictureUrl(user.getProfilePictureUrl());
        return userDto;
    }
}

