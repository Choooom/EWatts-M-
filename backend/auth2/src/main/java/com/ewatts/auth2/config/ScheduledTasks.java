package com.ewatts.auth2.config;

import com.ewatts.auth2.repository.OtpTokenRepository;
import com.ewatts.auth2.service.RefreshTokenService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
@Slf4j
public class ScheduledTasks {

    private final OtpTokenRepository otpTokenRepository;
    private final RefreshTokenService refreshTokenService;

    @Scheduled(fixedRate = 300000) // Run every 5 minutes
    @Transactional
    public void cleanupExpiredTokens() {
        log.info("Starting cleanup of expired tokens");

        // Clean up expired OTP tokens
        otpTokenRepository.deleteExpiredTokens(LocalDateTime.now());

        // Clean up expired refresh tokens
        refreshTokenService.deleteExpiredTokens();

        log.info("Completed cleanup of expired tokens");
    }
}
