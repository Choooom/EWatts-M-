package com.ewatts.electrical_readings.controller;

import com.ewatts.electrical_readings.dto.ApiResponse;
import com.ewatts.electrical_readings.dto.DeviceAssignmentRequest;
import com.ewatts.electrical_readings.dto.DeviceRegistrationRequest;
import com.ewatts.electrical_readings.entity.Device;
import com.ewatts.electrical_readings.service.DeviceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.UUID;

@RequestMapping("/readings/admin/devices")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    private final DeviceService deviceService;

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<UUID>> registerDevice(
            @RequestBody DeviceRegistrationRequest request) {

        try {
            Device device = deviceService.registerDevice(request);
            return ResponseEntity.ok(
                    new ApiResponse<>(true, "Device registered successfully", device.getId()));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Error registering device: " + e.getMessage(), null));
        }
    }

    @PostMapping("/assign")
    public ResponseEntity<ApiResponse<String>> assignDevice(
            @RequestBody DeviceAssignmentRequest request,
            @RequestHeader("Admin-ID") UUID adminId) {

        try {
            deviceService.assignDeviceToUser(request, adminId);
            return ResponseEntity.ok(
                    new ApiResponse<>(true, "Device assigned successfully", "OK"));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Error assigning device: " + e.getMessage(), null));
        }
    }
}
