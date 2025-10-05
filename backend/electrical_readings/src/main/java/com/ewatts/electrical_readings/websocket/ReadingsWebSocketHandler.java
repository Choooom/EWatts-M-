package com.ewatts.electrical_readings.websocket;

import com.ewatts.electrical_readings.service.WebSocketService;
import com.ewatts.electrical_readings.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import java.util.UUID;
import java.net.URI;

@Component
@RequiredArgsConstructor
@Slf4j
public class ReadingsWebSocketHandler implements WebSocketHandler {

    private final WebSocketService webSocketService;
    private final JwtUtils jwtUtils;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        try {
            // Extract JWT token from query parameters
            URI uri = session.getUri();
            String query = uri.getQuery();
            String token = extractTokenFromQuery(query);

            if (token != null && jwtUtils.validateJwtToken(token)) {
                UUID userId = jwtUtils.getUserIdFromJwtToken(token);
                session.getAttributes().put("userId", userId);
                webSocketService.addSession(session, userId);
                log.info("WebSocket connection established for user: {}", userId);
            } else {
                log.warn("Invalid token in WebSocket connection");
                session.close();
            }
        } catch (Exception e) {
            log.error("Error establishing WebSocket connection: {}", e.getMessage());
            session.close();
        }
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        // Handle incoming messages if needed (e.g., subscription to specific devices)
        log.debug("Received WebSocket message: {}", message.getPayload());
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        log.error("WebSocket transport error: {}", exception.getMessage());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        UUID userId = (UUID) session.getAttributes().get("userId");
        webSocketService.removeSession(session, userId);
        log.info("WebSocket connection closed for user: {}", userId);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    private String extractTokenFromQuery(String query) {
        if (query == null) return null;
        String[] params = query.split("&");
        for (String param : params) {
            if (param.startsWith("token=")) {
                return param.substring(6);
            }
        }
        return null;
    }
}

