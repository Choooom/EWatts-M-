package com.ewatts.electrical_readings.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuthServiceClient {

    private final RestTemplate restTemplate;

    public boolean validateUser(UUID userId) {
        try {
            // Use service ID instead of localhost URL
            String url = "http://auth-service/api/users/" + userId + "/validate";

            ResponseEntity<Boolean> response = restTemplate.getForEntity(url, Boolean.class);
            return Boolean.TRUE.equals(response.getBody());
        } catch (Exception e) {
            log.error("Error validating user {}: {}", userId, e.getMessage());
            return false;
        }
    }
}
