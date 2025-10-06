package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.entity.ElectricalDevice;
import com.ewatts.electricalreadings.exception.ResourceNotFoundException;
import com.ewatts.electricalreadings.repository.ElectricalDeviceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class SSRControlService {

    private final ElectricalDeviceRepository deviceRepository;
    private final WebSocketService webSocketService;
    private final MessageChannel mqttOutboundChannel;

    @Transactional
    public void controlSSR(Long deviceId, boolean enabled) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        // Update database
        device.setSsrEnabled(enabled);
        deviceRepository.save(device);

        // Send MQTT command to ESP32
        String topic = "electrical/control/" + device.getEsp32Id();
        String command = enabled ? "ON" : "OFF";

        Message<String> message = MessageBuilder
                .withPayload(command)
                .setHeader("mqtt_topic", topic)
                .build();

        mqttOutboundChannel.send(message);

        log.info("SSR control for device {} ({}): {}",
                device.getDeviceName(), deviceId, enabled ? "ON" : "OFF");

        // Notify user via WebSocket
        webSocketService.sendSSRStatusUpdate(device);
    }

    public boolean getSSRStatus(Long deviceId) {
        ElectricalDevice device = deviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));
        return device.getSsrEnabled();
    }
}