package com.ewatts.electricalreadings.controller;

import com.ewatts.electricalreadings.dto.*;
import com.ewatts.electricalreadings.service.DeviceService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/iot/admin/devices")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final DeviceService deviceService;

    @PostMapping
    public ResponseEntity<ApiResponse<DeviceResponse>> createDevice(
            @Valid @RequestBody CreateDeviceRequest request) {
        DeviceResponse device = deviceService.createDevice(request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Device created successfully", device));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<DeviceResponse>>> getAllDevices() {
        List<DeviceResponse> devices = deviceService.getAllDevices();
        return ResponseEntity.ok(ApiResponse.success(devices));
    }

    @GetMapping("/{deviceId}")
    public ResponseEntity<ApiResponse<DeviceResponse>> getDevice(
            @PathVariable Long deviceId) {
        DeviceResponse device = deviceService.getDevice(deviceId);
        return ResponseEntity.ok(ApiResponse.success(device));
    }

    @PutMapping("/{deviceId}")
    public ResponseEntity<ApiResponse<DeviceResponse>> updateDevice(
            @PathVariable Long deviceId,
            @Valid @RequestBody UpdateDeviceRequest request) {
        DeviceResponse device = deviceService.updateDevice(deviceId, request);
        return ResponseEntity.ok(ApiResponse.success("Device updated successfully", device));
    }

    @DeleteMapping("/{deviceId}")
    public ResponseEntity<ApiResponse<Void>> deleteDevice(@PathVariable Long deviceId) {
        deviceService.deleteDevice(deviceId);
        return ResponseEntity.ok(ApiResponse.success("Device deleted successfully", null));
    }

    @PostMapping("/{deviceId}/regenerate-token")
    public ResponseEntity<ApiResponse<DeviceResponse>> regenerateToken(
            @PathVariable Long deviceId) {
        DeviceResponse device = deviceService.regenerateDeviceToken(deviceId);
        return ResponseEntity.ok(ApiResponse.success("Token regenerated successfully", device));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<List<DeviceResponse>>> getUserDevices(
            @PathVariable Long userId) {
        List<DeviceResponse> devices = deviceService.getUserDevices(userId);
        return ResponseEntity.ok(ApiResponse.success(devices));
    }
}