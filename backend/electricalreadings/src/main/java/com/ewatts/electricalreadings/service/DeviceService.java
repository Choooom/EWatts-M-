package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.dto.CreateDeviceRequest;
import com.ewatts.electricalreadings.dto.DeviceResponse;
import com.ewatts.electricalreadings.dto.UpdateDeviceRequest;
import com.ewatts.electricalreadings.entity.ElectricalDevice;
import com.ewatts.electricalreadings.exception.ResourceNotFoundException;
import com.ewatts.electricalreadings.repository.ElectricalDeviceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeviceService {

    private final ElectricalDeviceRepository deviceRepository;
    private final WebSocketService webSocketService;

    @Transactional
    public DeviceResponse createDevice(CreateDeviceRequest request) {
        if (deviceRepository.existsByEsp32Id(request.getEsp32Id())) {
            throw new IllegalArgumentException("Device with ESP32 ID already exists");
        }

        ElectricalDevice device = new ElectricalDevice();
        device.setDeviceName(request.getDeviceName());
        device.setEsp32Id(request.getEsp32Id());
        device.setDeviceToken(generateDeviceToken());
        device.setDeviceType(request.getDeviceType());
        device.setUserId(request.getUserId());
        device.setUserEmail(request.getUserEmail());
        device.setDescription(request.getDescription());
        device.setLocation(request.getLocation());
        device.setInstallationNotes(request.getInstallationNotes());

        if (request.getVoltageCalibration() != null) {
            device.setVoltageCalibration(request.getVoltageCalibration());
        }
        if (request.getCurrentCalibration() != null) {
            device.setCurrentCalibration(request.getCurrentCalibration());
        }

        device.setSsrEnabled(true);
        device.setActive(true);
        device.setOnline(false);

        device = deviceRepository.save(device);
        log.info("Created new device: {} for user {}", device.getDeviceName(), device.getUserId());

        return mapToResponse(device);
    }

    @Transactional
    public DeviceResponse updateDevice(Long deviceId, UpdateDeviceRequest request) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        if (request.getDeviceName() != null) {
            device.setDeviceName(request.getDeviceName());
        }
        if (request.getDescription() != null) {
            device.setDescription(request.getDescription());
        }
        if (request.getLocation() != null) {
            device.setLocation(request.getLocation());
        }
        if (request.getInstallationNotes() != null) {
            device.setInstallationNotes(request.getInstallationNotes());
        }
        if (request.getVoltageCalibration() != null) {
            device.setVoltageCalibration(request.getVoltageCalibration());
        }
        if (request.getCurrentCalibration() != null) {
            device.setCurrentCalibration(request.getCurrentCalibration());
        }
        if (request.getActive() != null) {
            device.setActive(request.getActive());
        }

        device = deviceRepository.save(device);
        log.info("Updated device: {}", device.getId());

        return mapToResponse(device);
    }

    public DeviceResponse getDevice(Long deviceId) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));
        return mapToResponse(device);
    }

    public List<DeviceResponse> getUserDevices(Long userId) {
        return deviceRepository.findByUserId(userId).stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public List<DeviceResponse> getAllDevices() {
        return deviceRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void deleteDevice(Long deviceId) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        deviceRepository.delete(device);
        log.info("Deleted device: {}", deviceId);
    }

    @Transactional
    public DeviceResponse regenerateDeviceToken(Long deviceId) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        device.setDeviceToken(generateDeviceToken());
        device = deviceRepository.save(device);

        log.info("Regenerated token for device: {}", deviceId);
        return mapToResponse(device);
    }

    private String generateDeviceToken() {
        return "DEV_" + UUID.randomUUID().toString().replace("-", "");
    }

    private DeviceResponse mapToResponse(ElectricalDevice device) {
        return new DeviceResponse(
                device.getId(),
                device.getDeviceName(),
                device.getEsp32Id(),
                device.getDeviceToken(),
                device.getDeviceType(),
                device.getDescription(),
                device.getUserId(),
                device.getUserEmail(),
                device.getSsrEnabled(),
                device.getActive(),
                device.getOnline(),
                device.getLastSeenAt(),
                device.getVoltageCalibration(),
                device.getCurrentCalibration(),
                device.getLocation(),
                device.getInstallationNotes(),
                device.getCreatedAt(),
                device.getUpdatedAt()
        );
    }
}