package com.ewatts.auth2.service;

import com.ewatts.auth2.dto.AdminUserDto;
import com.ewatts.auth2.dto.UserStatsDto;
import com.ewatts.auth2.entity.AuthProvider;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.exception.BadRequestException;
import com.ewatts.auth2.exception.ResourceNotFoundException;
import com.ewatts.auth2.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public Page<AdminUserDto> getAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable)
                .map(this::convertToAdminDto);
    }

    @Transactional(readOnly = true)
    public AdminUserDto getUserById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", id));
        return convertToAdminDto(user);
    }

    @Transactional(readOnly = true)
    public Page<AdminUserDto> searchUsers(String username, String email, Pageable pageable) {
        if (username != null && !username.isEmpty()) {
            return userRepository.findByUsernameContainingIgnoreCase(username, pageable)
                    .map(this::convertToAdminDto);
        } else if (email != null && !email.isEmpty()) {
            return userRepository.findByEmailContainingIgnoreCase(email, pageable)
                    .map(this::convertToAdminDto);
        }
        return getAllUsers(pageable);
    }

    @Transactional(readOnly = true)
    public Page<AdminUserDto> getUsersByProvider(String providerStr, Pageable pageable) {
        try {
            AuthProvider provider = AuthProvider.valueOf(providerStr.toUpperCase());
            return userRepository.findByProvider(provider, pageable)
                    .map(this::convertToAdminDto);
        } catch (IllegalArgumentException e) {
            throw new BadRequestException("Invalid provider: " + providerStr);
        }
    }

    @Transactional(readOnly = true)
    public Page<AdminUserDto> getUsersByRole(String role, Pageable pageable) {
        return userRepository.findByRole(role.toUpperCase(), pageable)
                .map(this::convertToAdminDto);
    }

    @Transactional(readOnly = true)
    public Page<AdminUserDto> getUnverifiedUsers(Pageable pageable) {
        return userRepository.findByEmailVerified(false, pageable)
                .map(this::convertToAdminDto);
    }

    @Transactional(readOnly = true)
    public Page<AdminUserDto> getDisabledUsers(Pageable pageable) {
        return userRepository.findByAccountEnabled(false, pageable)
                .map(this::convertToAdminDto);
    }

    @Transactional
    public void enableUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));
        user.setAccountEnabled(true);
        userRepository.save(user);
    }

    @Transactional
    public void disableUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        if ("ADMIN".equals(user.getRole())) {
            throw new BadRequestException("Cannot disable admin users");
        }

        user.setAccountEnabled(false);
        userRepository.save(user);
    }

    @Transactional
    public void verifyUserEmail(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));
        user.setEmailVerified(true);
        userRepository.save(user);
    }

    @Transactional
    public void updateUserRole(Long userId, String role) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        String upperRole = role.toUpperCase();
        if (!upperRole.equals("USER") && !upperRole.equals("ADMIN")) {
            throw new BadRequestException("Invalid role. Allowed values: USER, ADMIN");
        }

        user.setRole(upperRole);
        userRepository.save(user);
    }

    @Transactional
    public void deleteUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));

        if ("ADMIN".equals(user.getRole())) {
            throw new BadRequestException("Cannot delete admin users");
        }

        userRepository.delete(user);
    }

    @Transactional(readOnly = true)
    public UserStatsDto getUserStats() {
        UserStatsDto stats = new UserStatsDto();

        // Total counts
        stats.setTotalUsers(userRepository.count());
        stats.setVerifiedUsers(userRepository.countByEmailVerified(true));
        stats.setUnverifiedUsers(userRepository.countByEmailVerified(false));
        stats.setEnabledUsers(userRepository.countByAccountEnabled(true));
        stats.setDisabledUsers(userRepository.countByAccountEnabled(false));
        stats.setTotalAdmins(userRepository.countByRole("ADMIN"));
        stats.setTotalRegularUsers(userRepository.countByRole("USER"));

        // Users by provider
        Map<String, Long> providerStats = new HashMap<>();
        for (AuthProvider provider : AuthProvider.values()) {
            long count = userRepository.countByProvider(provider);
            providerStats.put(provider.name(), count);
        }
        stats.setUsersByProvider(providerStats);

        // Time-based statistics
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfDay = now.truncatedTo(ChronoUnit.DAYS);
        LocalDateTime startOfWeek = now.minusDays(7);
        LocalDateTime startOfMonth = now.minusDays(30);

        stats.setUsersCreatedToday(userRepository.countByCreatedAtAfter(startOfDay));
        stats.setUsersCreatedThisWeek(userRepository.countByCreatedAtAfter(startOfWeek));
        stats.setUsersCreatedThisMonth(userRepository.countByCreatedAtAfter(startOfMonth));

        return stats;
    }

    private AdminUserDto convertToAdminDto(User user) {
        AdminUserDto dto = new AdminUserDto();
        dto.setId(user.getId());
        dto.setRole(user.getRole());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setPhoneNumber(user.getPhoneNumber());
        dto.setEmailVerified(user.isEmailVerified());
        dto.setAccountEnabled(user.isAccountEnabled());
        dto.setProvider(user.getProvider());
        dto.setProviderId(user.getProviderId());
        dto.setCreatedAt(user.getCreatedAt());
        dto.setUpdatedAt(user.getUpdatedAt());
        dto.setProfilePictureUrl(user.getProfilePictureUrl());
        dto.setDeviceCount(user.getDevices() != null ? user.getDevices().size() : 0);
        return dto;
    }
}