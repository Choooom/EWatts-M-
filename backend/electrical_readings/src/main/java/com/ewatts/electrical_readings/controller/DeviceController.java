package com.ewatts.electrical_readings.controller;

import com.ewatts.electrical_readings.dto.*;
import com.ewatts.electrical_readings.entity.Device;
import com.ewatts.electrical_readings.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/readings/devices")
@RequiredArgsConstructor
public class DeviceController {

    private final DeviceService deviceService;
    private final UserDeviceAssignmentService assignmentService;

    @GetMapping("/my-devices")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse<List<DeviceDto>>> getMyDevices(Principal principal) {
        try {
            UUID userId = UUID.fromString(principal.getName());
            List<Device> devices = deviceService.getUserDevices(userId);
            List<DeviceDto> deviceDtos = devices.stream()
                    .map(this::convertToDto)
                    .toList();

            return ResponseEntity.ok(
                    new ApiResponse<>(true, "Devices retrieved successfully", deviceDtos));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Error retrieving devices: " + e.getMessage(), null));
        }
    }

    @GetMapping("/{deviceId}/status")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse<DeviceStatusDto>> getDeviceStatus(
            @PathVariable String deviceId, Principal principal) {
        try {
            UUID userId = UUID.fromString(principal.getName());
            // Check if user has access to this device
            if (!assignmentService.hasUserAccessToDevice(userId, deviceId)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body(new ApiResponse<>(false, "Access denied to device", null));
            }

            DeviceStatusDto status = deviceService.getDeviceStatus(deviceId);
            return ResponseEntity.ok(
                    new ApiResponse<>(true, "Device status retrieved", status));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Error retrieving device status: " + e.getMessage(), null));
        }
    }

    private DeviceDto convertToDto(Device device) {
        DeviceDto dto = new DeviceDto();
        dto.setId(device.getId());
        dto.setDeviceId(device.getDeviceId());
        dto.setDeviceName(device.getDeviceName());
        dto.setLocation(device.getLocation());
        dto.setStatus(device.getStatus().name());
        dto.setLastSeen(device.getLastSeen());
        dto.setCreatedAt(device.getCreatedAt());
        return dto;
    }
}
