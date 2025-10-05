package com.ewatts.electrical_readings.service;

import com.ewatts.electrical_readings.entity.Device;
import com.ewatts.electrical_readings.repository.DeviceRepository;
import com.ewatts.electrical_readings.repository.UserDeviceAssignmentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserDeviceAssignmentService {

    private final UserDeviceAssignmentRepository assignmentRepository;
    private final DeviceRepository deviceRepository;

    public boolean hasUserAccessToDevice(UUID userId, String deviceId) {
        Device device = deviceRepository.findByDeviceId(deviceId)
                .orElse(null);

        if (device == null) {
            return false;
        }

        return assignmentRepository
                .findByUserIdAndDeviceIdAndActive(userId, device.getId(), true)
                .isPresent();
    }
}
