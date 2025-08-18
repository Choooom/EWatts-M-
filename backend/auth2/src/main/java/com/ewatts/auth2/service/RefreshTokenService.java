package com.ewatts.auth2.service;

import com.ewatts.auth2.dto.UserDto;
import com.ewatts.auth2.entity.RefreshToken;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.exception.BadRequestException;
import com.ewatts.auth2.exception.ResourceNotFoundException;
import com.ewatts.auth2.exception.TokenRefreshException;
import com.ewatts.auth2.repository.RefreshTokenRepository;
import com.ewatts.auth2.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class RefreshTokenService {

    @Value("${app.jwt.refresh-expiration-ms}")
    private Long refreshTokenDurationMs;

    private final RefreshTokenRepository refreshTokenRepository;
    private final UserRepository userRepository;

    public Optional<RefreshToken> findByToken(String token) {
        return refreshTokenRepository.findByToken(token);
    }

    public RefreshToken createRefreshToken(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        // Delete existing refresh token for this user to ensure one token per user
        Optional<RefreshToken> existingToken = refreshTokenRepository.findByUser(user);
        existingToken.ifPresent(token -> {
            refreshTokenRepository.delete(token);
            refreshTokenRepository.flush(); // ensure the DELETE is executed immediately
        });

        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setUser(user);
        refreshToken.setExpiryDate(Instant.now().plusMillis(refreshTokenDurationMs));
        refreshToken.setToken(UUID.randomUUID().toString());

        RefreshToken savedToken = refreshTokenRepository.save(refreshToken);
        log.info("Created new refresh token for user: {}", user.getUsername());

        return savedToken;
    }

    public RefreshToken verifyExpiration(RefreshToken token) {
        if (token.getExpiryDate().compareTo(Instant.now()) < 0) {
            refreshTokenRepository.delete(token);
            log.warn("Refresh token expired for user: {}", token.getUser().getUsername());
            throw new TokenRefreshException(token.getToken(),
                    "Refresh token was expired. Please make a new signin request");
        }
        return token;
    }

    @Transactional
    public int deleteByUserId(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByUser(user);
        if (refreshToken.isPresent()) {
            refreshTokenRepository.delete(refreshToken.get());
            log.info("Deleted refresh token for user: {}", user.getUsername());
            return 1;
        }
        return 0;
    }

    @Transactional
    public void deleteExpiredTokens() {
        int deletedCount = refreshTokenRepository.deleteExpiredTokens(Instant.now());
        if (deletedCount > 0) {
            log.info("Deleted {} expired refresh tokens", deletedCount);
        }
    }

    public void deleteByToken(String token) {
        refreshTokenRepository.deleteByToken(token);
    }

    public void revokeRefreshToken(String token) {
        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByToken(token);
        if (refreshToken.isPresent()) {
            refreshTokenRepository.delete(refreshToken.get());
            log.info("Revoked refresh token for user: {}", refreshToken.get().getUser().getUsername());
        }
    }

    public void revokeAllUserTokens(Long userId) {
        deleteByUserId(userId);
        log.info("Revoked all refresh tokens for user id: {}", userId);
    }

    public boolean isTokenValid(String token) {
        return refreshTokenRepository.findByToken(token)
                .map(refreshToken -> {
                    try {
                        verifyExpiration(refreshToken);
                        return true;
                    } catch (TokenRefreshException e) {
                        return false;
                    }
                })
                .orElse(false);
    }
}
