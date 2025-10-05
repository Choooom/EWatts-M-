package com.ewatts.auth2.controller;

import com.ewatts.auth2.dto.ApiResponse;
import com.ewatts.auth2.entity.Device;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.repository.DeviceRepository;
import com.ewatts.auth2.repository.UserRepository;
import com.ewatts.auth2.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/auth/devices")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*", maxAge = 3600)
public class DeviceController {

    private final DeviceRepository deviceRepository;
    private final UserRepository userRepository;

    @GetMapping
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse> getUserDevices(@AuthenticationPrincipal UserPrincipal userPrincipal) {
        log.info("Get devices request for user: {}", userPrincipal.getUsername());

        User user = userRepository.findById(userPrincipal.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        List<Device> devices = deviceRepository.findByUser(user);
        ApiResponse response = new ApiResponse(true, "Devices retrieved successfully", devices);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{deviceId}")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse> getDevice(@PathVariable String deviceId,
                                                 @AuthenticationPrincipal UserPrincipal userPrincipal) {
        log.info("Get device request for deviceId: {} by user: {}", deviceId, userPrincipal.getUsername());

        Device device = deviceRepository.findByDeviceId(deviceId)
                .orElseThrow(() -> new RuntimeException("Device not found"));

        // Check if device belongs to the user
        if (!device.getUser().getId().equals(userPrincipal.getId())) {
            return ResponseEntity.status(403).body(new ApiResponse(false, "Access denied"));
        }

        ApiResponse response = new ApiResponse(true, "Device retrieved successfully", device);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{deviceId}/ssr")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<ApiResponse> controlSSR(@PathVariable String deviceId,
                                                  @RequestParam Boolean state,
                                                  @AuthenticationPrincipal UserPrincipal userPrincipal) {
        log.info("SSR control request for deviceId: {} state: {} by user: {}",
                deviceId, state, userPrincipal.getUsername());

        Device device = deviceRepository.findByDeviceId(deviceId)
                .orElseThrow(() -> new RuntimeException("Device not found"));

        // Check if device belongs to the user
        if (!device.getUser().getId().equals(userPrincipal.getId())) {
            return ResponseEntity.status(403).body(new ApiResponse(false, "Access denied"));
        }

        device.setSsrState(state);
        deviceRepository.save(device);

        ApiResponse response = new ApiResponse(true, "SSR state updated successfully");
        return ResponseEntity.ok(response);
    }
}
