package com.ewatts.electricalreadings.service;

import com.ewatts.electricalreadings.dto.RealtimeReadingEvent;
import com.ewatts.electricalreadings.dto.WebSocketMessage;
import com.ewatts.electricalreadings.entity.ElectricalDevice;
import com.ewatts.electricalreadings.entity.ElectricalReading;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class WebSocketService {

    private final SimpMessagingTemplate messagingTemplate;

    public void sendReadingUpdate(ElectricalDevice device, ElectricalReading reading) {
        RealtimeReadingEvent event = new RealtimeReadingEvent(
                device.getId(),
                device.getDeviceName(),
                device.getDeviceType(),
                device.getUserId(),
                reading.getVoltage(),
                reading.getCurrent(),
                reading.getPower(),
                reading.getEnergy(),
                device.getSsrEnabled(),
                reading.getTimestamp()
        );

        WebSocketMessage wsMessage = new WebSocketMessage(
                "READING",
                event,
                LocalDateTime.now()
        );

        String destination = "/topic/user/" + device.getUserId() + "/readings";
        messagingTemplate.convertAndSend(destination, wsMessage);

        log.debug("Sent reading update to user {} via WebSocket", device.getUserId());
    }

    public void sendSSRStatusUpdate(ElectricalDevice device) {
        WebSocketMessage wsMessage = new WebSocketMessage(
                "SSR_CONTROL",
                device,
                LocalDateTime.now()
        );

        String destination = "/topic/user/" + device.getUserId() + "/ssr-control";
        messagingTemplate.convertAndSend(destination, wsMessage);

        log.debug("Sent SSR status update to user {} via WebSocket", device.getUserId());
    }

    public void sendDeviceStatusUpdate(ElectricalDevice device) {
        WebSocketMessage wsMessage = new WebSocketMessage(
                "DEVICE_STATUS",
                device,
                LocalDateTime.now()
        );

        String destination = "/topic/user/" + device.getUserId() + "/device-status";
        messagingTemplate.convertAndSend(destination, wsMessage);

        log.debug("Sent device status update to user {} via WebSocket", device.getUserId());
    }
}
