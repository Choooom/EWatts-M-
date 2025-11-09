package com.ewatts.auth2.controller;


import com.ewatts.auth2.dto.AdminUserDto;
import com.ewatts.auth2.dto.ApiResponse;
import com.ewatts.auth2.dto.UserStatsDto;
import com.ewatts.auth2.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/users")
    public ResponseEntity<ApiResponse> getAllUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "id") String sortBy,
            @RequestParam(defaultValue = "DESC") String sortDirection) {

        Sort.Direction direction = sortDirection.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortBy));

        Page<AdminUserDto> users = adminService.getAllUsers(pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Users retrieved successfully", users));
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<ApiResponse> getUserById(@PathVariable Long id) {
        AdminUserDto user = adminService.getUserById(id);
        return ResponseEntity.ok(new ApiResponse(true, "User retrieved successfully", user));
    }

    @GetMapping("/users/search")
    public ResponseEntity<ApiResponse> searchUsers(
            @RequestParam(required = false) String username,
            @RequestParam(required = false) String email,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<AdminUserDto> users = adminService.searchUsers(username, email, pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Users retrieved successfully", users));
    }

    @GetMapping("/users/provider/{provider}")
    public ResponseEntity<ApiResponse> getUsersByProvider(
            @PathVariable String provider,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<AdminUserDto> users = adminService.getUsersByProvider(provider, pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Users retrieved successfully", users));
    }

    @GetMapping("/users/role/{role}")
    public ResponseEntity<ApiResponse> getUsersByRole(
            @PathVariable String role,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<AdminUserDto> users = adminService.getUsersByRole(role, pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Users retrieved successfully", users));
    }

    @PutMapping("/users/{id}/enable")
    public ResponseEntity<ApiResponse> enableUser(@PathVariable Long id) {
        adminService.enableUser(id);
        return ResponseEntity.ok(new ApiResponse(true, "User enabled successfully"));
    }

    @PutMapping("/users/{id}/disable")
    public ResponseEntity<ApiResponse> disableUser(@PathVariable Long id) {
        adminService.disableUser(id);
        return ResponseEntity.ok(new ApiResponse(true, "User disabled successfully"));
    }

    @PutMapping("/users/{id}/verify-email")
    public ResponseEntity<ApiResponse> verifyUserEmail(@PathVariable Long id) {
        adminService.verifyUserEmail(id);
        return ResponseEntity.ok(new ApiResponse(true, "User email verified successfully"));
    }

    @PutMapping("/users/{id}/role")
    public ResponseEntity<ApiResponse> updateUserRole(
            @PathVariable Long id,
            @RequestParam String role) {
        adminService.updateUserRole(id, role);
        return ResponseEntity.ok(new ApiResponse(true, "User role updated successfully"));
    }

    @DeleteMapping("/users/{id}")
    public ResponseEntity<ApiResponse> deleteUser(@PathVariable Long id) {
        adminService.deleteUser(id);
        return ResponseEntity.ok(new ApiResponse(true, "User deleted successfully"));
    }

    @GetMapping("/stats")
    public ResponseEntity<ApiResponse> getUserStats() {
        UserStatsDto stats = adminService.getUserStats();
        return ResponseEntity.ok(new ApiResponse(true, "Statistics retrieved successfully", stats));
    }

    @GetMapping("/users/recent")
    public ResponseEntity<ApiResponse> getRecentUsers(
            @RequestParam(defaultValue = "10") int limit) {

        Pageable pageable = PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<AdminUserDto> users = adminService.getAllUsers(pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Recent users retrieved successfully", users));
    }

    @GetMapping("/users/unverified")
    public ResponseEntity<ApiResponse> getUnverifiedUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<AdminUserDto> users = adminService.getUnverifiedUsers(pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Unverified users retrieved successfully", users));
    }

    @GetMapping("/users/disabled")
    public ResponseEntity<ApiResponse> getDisabledUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<AdminUserDto> users = adminService.getDisabledUsers(pageable);
        return ResponseEntity.ok(new ApiResponse(true, "Disabled users retrieved successfully", users));
    }
}