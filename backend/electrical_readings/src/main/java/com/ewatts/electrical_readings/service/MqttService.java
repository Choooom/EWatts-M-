package com.ewatts.electrical_readings.service;

import com.ewatts.electrical_readings.dto.ElectricalReadingDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class MqttService implements MqttCallback {

    private final ElectricalReadingsService readingsService;
    private final ObjectMapper objectMapper;

    @Value("${mqtt.broker-url}")
    private String brokerUrl;

    @Value("${mqtt.client-id}")
    private String clientId;

    @Value("${mqtt.username}")
    private String username;

    @Value("${mqtt.password}")
    private String password;

    @Value("${mqtt.topic}")
    private String topic;

    private MqttClient mqttClient;

    @PostConstruct
    public void initialize() {
        try {
            mqttClient = new MqttClient(brokerUrl, clientId);
            mqttClient.setCallback(this);

            MqttConnectOptions options = new MqttConnectOptions();
            options.setUserName(username);
            options.setPassword(password.toCharArray());
            options.setCleanSession(true);
            options.setAutomaticReconnect(true);

            mqttClient.connect(options);
            mqttClient.subscribe(topic, 1);

            log.info("MQTT client connected to broker: {}", brokerUrl);
        } catch (Exception e) {
            log.error("Error initializing MQTT client: {}", e.getMessage());
        }
    }

    @PreDestroy
    public void cleanup() {
        try {
            if (mqttClient != null && mqttClient.isConnected()) {
                mqttClient.disconnect();
            }
        } catch (Exception e) {
            log.error("Error disconnecting MQTT client: {}", e.getMessage());
        }
    }

    @Override
    public void connectionLost(Throwable cause) {
        log.warn("MQTT connection lost: {}", cause.getMessage());
    }

    @Override
    public void messageArrived(String topic, MqttMessage message) throws Exception {
        try {
            String payload = new String(message.getPayload());
            log.debug("MQTT message received from topic {}: {}", topic, payload);

            // Parse JSON message
            ElectricalReadingDto reading = objectMapper.readValue(payload, ElectricalReadingDto.class);
            reading.setTimestamp(LocalDateTime.now());

            // Process the reading
            readingsService.processReading(reading);

        } catch (Exception e) {
            log.error("Error processing MQTT message: {}", e.getMessage());
        }
    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken token) {
        // Not used for subscriber
    }
}
