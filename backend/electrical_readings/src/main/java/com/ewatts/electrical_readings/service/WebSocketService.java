package com.ewatts.electrical_readings.service;

import com.ewatts.electrical_readings.dto.RealTimeReadingDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class WebSocketService {

    private final ObjectMapper objectMapper;
    private final Set<WebSocketSession> sessions = ConcurrentHashMap.newKeySet();
    private final Map<String, Set<WebSocketSession>> userSessions = new ConcurrentHashMap<>();

    public void addSession(WebSocketSession session, UUID userId) {
        sessions.add(session);
        userSessions.computeIfAbsent(userId.toString(), k -> ConcurrentHashMap.newKeySet())
                .add(session);
        log.info("Added WebSocket session for user: {}", userId);
    }

    public void removeSession(WebSocketSession session, UUID userId) {
        sessions.remove(session);
        if (userId != null) {
            Set<WebSocketSession> userSessionSet = userSessions.get(userId.toString());
            if (userSessionSet != null) {
                userSessionSet.remove(session);
                if (userSessionSet.isEmpty()) {
                    userSessions.remove(userId.toString());
                }
            }
        }
        log.info("Removed WebSocket session for user: {}", userId);
    }

    public void broadcastReading(RealTimeReadingDto reading) {
        if (sessions.isEmpty()) {
            return;
        }

        try {
            String message = objectMapper.writeValueAsString(reading);
            TextMessage textMessage = new TextMessage(message);

            sessions.removeIf(session -> {
                try {
                    if (session.isOpen()) {
                        session.sendMessage(textMessage);
                        return false;
                    }
                } catch (Exception e) {
                    log.error("Error sending WebSocket message: {}", e.getMessage());
                }
                return true; // Remove closed sessions
            });

        } catch (Exception e) {
            log.error("Error broadcasting reading: {}", e.getMessage());
        }
    }

    public void sendReadingToUser(UUID userId, RealTimeReadingDto reading) {
        Set<WebSocketSession> userSessionSet = userSessions.get(userId.toString());
        if (userSessionSet == null || userSessionSet.isEmpty()) {
            return;
        }

        try {
            String message = objectMapper.writeValueAsString(reading);
            TextMessage textMessage = new TextMessage(message);

            userSessionSet.removeIf(session -> {
                try {
                    if (session.isOpen()) {
                        session.sendMessage(textMessage);
                        return false;
                    }
                } catch (Exception e) {
                    log.error("Error sending WebSocket message to user {}: {}", userId, e.getMessage());
                }
                return true;
            });

        } catch (Exception e) {
            log.error("Error sending reading to user {}: {}", userId, e.getMessage());
        }
    }
}
