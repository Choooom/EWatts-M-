package com.ewatts.electricalreadings.controller;

import com.ewatts.electricalreadings.dto.*;
import com.ewatts.electricalreadings.service.DeviceService;
import com.ewatts.electricalreadings.service.SSRControlService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/iot/devices")
@RequiredArgsConstructor
public class DeviceController {

    private final DeviceService deviceService;
    private final SSRControlService ssrControlService;

    @GetMapping("/my-devices")
    public ResponseEntity<ApiResponse<List<DeviceResponse>>> getMyDevices(
            Authentication authentication) {
        Long userId = (Long) authentication.getPrincipal();
        List<DeviceResponse> devices = deviceService.getUserDevices(userId);
        return ResponseEntity.ok(ApiResponse.success(devices));
    }

    @GetMapping("/{deviceId}")
    public ResponseEntity<ApiResponse<DeviceResponse>> getDevice(
            @PathVariable Long deviceId,
            Authentication authentication) {
        Long userId = (Long) authentication.getPrincipal();
        DeviceResponse device = deviceService.getDevice(deviceId);

        if (!device.getUserId().equals(userId)) {
            return ResponseEntity.status(403)
                    .body(ApiResponse.error("Access denied"));
        }

        return ResponseEntity.ok(ApiResponse.success(device));
    }

    @PostMapping("/{deviceId}/ssr-control")
    public ResponseEntity<ApiResponse<String>> controlSSR(
            @PathVariable Long deviceId,
            @Valid @RequestBody SSRControlRequest request,
            Authentication authentication) {
        Long userId = (Long) authentication.getPrincipal();
        DeviceResponse device = deviceService.getDevice(deviceId);

        if (!device.getUserId().equals(userId)) {
            return ResponseEntity.status(403)
                    .body(ApiResponse.error("Access denied"));
        }

        ssrControlService.controlSSR(deviceId, request.getEnabled());
        String message = request.getEnabled() ? "Device turned ON" : "Device turned OFF";
        return ResponseEntity.ok(ApiResponse.success(message, null));
    }

    @GetMapping("/{deviceId}/ssr-status")
    public ResponseEntity<ApiResponse<Boolean>> getSSRStatus(
            @PathVariable Long deviceId,
            Authentication authentication) {
        Long userId = (Long) authentication.getPrincipal();
        DeviceResponse device = deviceService.getDevice(deviceId);

        if (!device.getUserId().equals(userId)) {
            return ResponseEntity.status(403)
                    .body(ApiResponse.error("Access denied"));
        }

        boolean status = ssrControlService.getSSRStatus(deviceId);
        return ResponseEntity.ok(ApiResponse.success(status));
    }
}
