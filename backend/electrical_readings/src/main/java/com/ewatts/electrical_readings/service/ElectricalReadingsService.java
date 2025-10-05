package com.ewatts.electrical_readings.service;

import com.ewatts.electrical_readings.dto.ElectricalReadingDto;
import com.ewatts.electrical_readings.dto.RealTimeReadingDto;
import com.ewatts.electrical_readings.entity.DeviceStatus;
import com.ewatts.electrical_readings.repository.InfluxDBRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class ElectricalReadingsService {

    private final InfluxDBRepository influxDBRepository;
    private final DeviceService deviceService;
    private final WebSocketService webSocketService;

    public void processReading(ElectricalReadingDto reading) {
        try {
            // Validate reading
            validateReading(reading);

            // Update device last seen
            deviceService.updateDeviceStatus(reading.getDeviceId(), DeviceStatus.ACTIVE);

            // Save to InfluxDB
            influxDBRepository.saveReading(reading);

            // Send real-time update via WebSocket
            RealTimeReadingDto realTimeReading = convertToRealTimeDto(reading);
            webSocketService.broadcastReading(realTimeReading);

            log.info("Processed reading for device: {}", reading.getDeviceId());

        } catch (Exception e) {
            log.error("Error processing reading for device {}: {}",
                    reading.getDeviceId(), e.getMessage());
            throw e;
        }
    }

    private void validateReading(ElectricalReadingDto reading) {
        if (reading.getVoltage() < 0 || reading.getVoltage() > 300) {
            throw new IllegalArgumentException("Invalid voltage reading");
        }
        if (reading.getCurrent() < 0 || reading.getCurrent() > 100) {
            throw new IllegalArgumentException("Invalid current reading");
        }
        if (reading.getPower() < 0) {
            throw new IllegalArgumentException("Invalid power reading");
        }
    }

    private RealTimeReadingDto convertToRealTimeDto(ElectricalReadingDto reading) {
        RealTimeReadingDto realTime = new RealTimeReadingDto();
        realTime.setDeviceId(reading.getDeviceId());
        realTime.setVoltage(reading.getVoltage());
        realTime.setCurrent(reading.getCurrent());
        realTime.setPower(reading.getPower());
        realTime.setEnergy(reading.getEnergy());
        realTime.setTimestamp(reading.getTimestamp());
        realTime.setLocation(reading.getLocation());
        realTime.setStatus("ACTIVE");
        return realTime;
    }
}
