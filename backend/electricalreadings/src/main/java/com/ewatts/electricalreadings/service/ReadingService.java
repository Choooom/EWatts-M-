package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.dto.ReadingResponse;
import com.ewatts.electricalreadings.entity.ElectricalDevice;
import com.ewatts.electricalreadings.entity.ElectricalReading;
import com.ewatts.electricalreadings.exception.ResourceNotFoundException;
import com.ewatts.electricalreadings.repository.ElectricalDeviceRepository;
import com.ewatts.electricalreadings.repository.ElectricalReadingRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReadingService {

    private final ElectricalReadingRepository readingRepository;
    private final ElectricalDeviceRepository deviceRepository;

    public Page<ReadingResponse> getDeviceReadings(Long deviceId, int page, int size) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        Pageable pageable = PageRequest.of(page, size);
        Page<ElectricalReading> readings = readingRepository
                .findByDeviceIdOrderByTimestampDesc(deviceId, pageable);

        return readings.map(reading -> mapToResponse(reading, device));
    }

    public Page<ReadingResponse> getUserReadings(Long userId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ElectricalReading> readings = readingRepository
                .findByUserIdOrderByTimestampDesc(userId, pageable);

        List<ElectricalDevice> devices = deviceRepository.findByUserId(userId);
        Map<Long, ElectricalDevice> deviceMap = devices.stream()
                .collect(Collectors.toMap(ElectricalDevice::getId, Function.identity()));

        return readings.map(reading -> {
            ElectricalDevice device = deviceMap.get(reading.getDeviceId());
            return mapToResponse(reading, device);
        });
    }

    public List<ReadingResponse> getDeviceReadingsByDateRange(
            Long deviceId, LocalDateTime start, LocalDateTime end) {

        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        List<ElectricalReading> readings = readingRepository
                .findByDeviceIdAndTimestampBetweenOrderByTimestampDesc(deviceId, start, end);

        return readings.stream()
                .map(reading -> mapToResponse(reading, device))
                .collect(Collectors.toList());
    }

    public ReadingResponse getLatestReading(Long deviceId) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        ElectricalReading reading = readingRepository
                .findFirstByDeviceIdOrderByTimestampDesc(deviceId);

        if (reading == null) {
            throw new ResourceNotFoundException("No readings found for device");
        }

        return mapToResponse(reading, device);
    }

    private ReadingResponse mapToResponse(ElectricalReading reading, ElectricalDevice device) {
        return new ReadingResponse(
                reading.getId(),
                reading.getDeviceId(),
                device != null ? device.getDeviceName() : "Unknown",
                device != null ? device.getDeviceType() : null,
                reading.getVoltage(),
                reading.getCurrent(),
                reading.getPower(),
                reading.getEnergy(),
                reading.getTimestamp()
        );
    }
}
