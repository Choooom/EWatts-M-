package com.ewatts.electrical_readings.service;

import com.ewatts.electrical_readings.dto.*;
import com.ewatts.electrical_readings.entity.*;
import com.ewatts.electrical_readings.repository.*;
import com.ewatts.electrical_readings.exception.DeviceNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeviceService {

    private final DeviceRepository deviceRepository;
    private final UserDeviceAssignmentRepository assignmentRepository;

    @Transactional
    public Device registerDevice(DeviceRegistrationRequest request) {
        // Check if device already exists
        if (deviceRepository.findByDeviceId(request.getDeviceId()).isPresent()) {
            throw new IllegalArgumentException("Device already registered: " + request.getDeviceId());
        }

        Device device = new Device();
        device.setDeviceId(request.getDeviceId());
        device.setDeviceName(request.getDeviceName());
        device.setLocation(request.getLocation());
        device.setVoltageCalibration(request.getVoltageCalibration());
        device.setCurrentCalibration(request.getCurrentCalibration());
        device.setFirmwareVersion(request.getFirmwareVersion());
        device.setHardwareVersion(request.getHardwareVersion());
        device.setStatus(DeviceStatus.ACTIVE);
        device.setCreatedAt(LocalDateTime.now());

        return deviceRepository.save(device);
    }

    @Transactional
    public void assignDeviceToUser(DeviceAssignmentRequest request, UUID adminId) {
        Device device = deviceRepository.findById(request.getDeviceId())
                .orElseThrow(() -> new DeviceNotFoundException("Device not found"));

        // Check if already assigned
        if (assignmentRepository.findByUserIdAndDeviceIdAndActive(
                request.getUserId(), request.getDeviceId(), true).isPresent()) {
            throw new IllegalArgumentException("Device already assigned to user");
        }

        UserDeviceAssignment assignment = new UserDeviceAssignment();
        assignment.setUserId(request.getUserId());
        assignment.setDeviceId(request.getDeviceId());
        assignment.setAssignedBy(adminId);
        assignment.setAssignedAt(LocalDateTime.now());
        assignment.setActive(true);

        assignmentRepository.save(assignment);
    }

    public List<Device> getUserDevices(UUID userId) {
        List<UserDeviceAssignment> assignments = assignmentRepository
                .findByUserIdAndActive(userId, true);

        return assignments.stream()
                .map(assignment -> deviceRepository.findById(assignment.getDeviceId()))
                .<Device>mapMulti((opt, consumer) -> opt.ifPresent(consumer))
                .toList();
    }

    public DeviceStatusDto getDeviceStatus(String deviceId) {
        Device device = deviceRepository.findByDeviceId(deviceId)
                .orElseThrow(() -> new DeviceNotFoundException("Device not found: " + deviceId));

        DeviceStatusDto statusDto = new DeviceStatusDto();
        statusDto.setDeviceId(device.getDeviceId());
        statusDto.setDeviceName(device.getDeviceName());
        statusDto.setStatus(device.getStatus().name());
        statusDto.setLastSeen(device.getLastSeen());
        statusDto.setLocation(device.getLocation());
        statusDto.setOnline(device.getStatus() == DeviceStatus.ACTIVE &&
                device.getLastSeen() != null &&
                device.getLastSeen().isAfter(LocalDateTime.now().minusMinutes(5)));

        // TODO: Get latest readings from InfluxDB for lastVoltage, lastCurrent, etc.
        // This would require a method to query InfluxDB for the latest reading

        return statusDto;
    }

    public void updateDeviceStatus(String deviceId, DeviceStatus status) {
        Device device = deviceRepository.findByDeviceId(deviceId)
                .orElseThrow(() -> new DeviceNotFoundException("Device not found: " + deviceId));

        device.setStatus(status);
        device.setLastSeen(LocalDateTime.now());
        deviceRepository.save(device);
    }
}
