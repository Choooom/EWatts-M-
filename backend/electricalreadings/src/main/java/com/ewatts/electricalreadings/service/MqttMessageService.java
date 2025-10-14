package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.dto.ReadingMessage;
import com.ewatts.electricalreadings.entity.ElectricalDevice;
import com.ewatts.electricalreadings.entity.ElectricalReading;
import com.ewatts.electricalreadings.repository.ElectricalDeviceRepository;
import com.ewatts.electricalreadings.repository.ElectricalReadingRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class MqttMessageService {

    private final ElectricalDeviceRepository deviceRepository;
    private final ElectricalReadingRepository readingRepository;
    private final WebSocketService webSocketService;
    private final ObjectMapper objectMapper;

    @ServiceActivator(inputChannel = "mqttInputChannel")
    @Transactional
    public void handleIncomingMessage(Message<?> message) {
        try {
            Object rawPayload = message.getPayload();
            String payload;

            if (rawPayload instanceof byte[]) {
                payload = new String((byte[]) rawPayload, StandardCharsets.UTF_8);
            } else if (rawPayload instanceof String) {
                payload = (String) rawPayload;
            } else {
                log.warn("Unsupported payload type: {}", rawPayload.getClass().getName());
                return;
            }

            log.debug("Received MQTT message: {}", payload);

            ReadingMessage readingMsg = objectMapper.readValue(payload, ReadingMessage.class);

            // Validate device token
            Optional<ElectricalDevice> deviceOpt =
                    deviceRepository.findByDeviceToken(readingMsg.getDeviceToken());

            if (deviceOpt.isEmpty()) {
                log.warn("Invalid device token: {}", readingMsg.getDeviceToken());
                return;
            }

            ElectricalDevice device = deviceOpt.get();

            // Update device status
            device.setOnline(true);
            device.setLastSeenAt(LocalDateTime.now());
            deviceRepository.save(device);

            // Save reading
            ElectricalReading reading = new ElectricalReading();
            reading.setDeviceId(device.getId());
            reading.setUserId(device.getUserId());
            reading.setVoltage(readingMsg.getVoltage());
            reading.setCurrent(readingMsg.getCurrent());
            reading.setPower(readingMsg.getPower());
            reading.setEnergy(readingMsg.getEnergy());

            // Convert Unix timestamp to LocalDateTime
            LocalDateTime timestamp = LocalDateTime.ofInstant(
                    Instant.ofEpochMilli(readingMsg.getTimestamp()),
                    ZoneId.systemDefault()
            );
            reading.setTimestamp(timestamp);

            reading = readingRepository.save(reading);

            log.info("Saved reading for device {} ({}): {}W, {}kWh",
                    device.getDeviceName(), device.getId(),
                    readingMsg.getPower(), readingMsg.getEnergy());

            // Send real-time update via WebSocket
            webSocketService.sendReadingUpdate(device, reading);

        } catch (Exception e) {
            log.error("Error processing MQTT message: {}", e.getMessage(), e);
        }
    }

    public void sendSSRCommand(String esp32Id, boolean enabled) {
        try {
            String topic = "electrical/control/" + esp32Id;
            String command = enabled ? "ON" : "OFF";

            Message<String> message = MessageBuilder
                    .withPayload(command)
                    .setHeader("mqtt_topic", topic)
                    .build();

            // This will be sent through mqttOutboundChannel
            log.info("Sending SSR command to {}: {}", esp32Id, command);

        } catch (Exception e) {
            log.error("Error sending SSR command: {}", e.getMessage(), e);
        }
    }
}