package com.ewatts.auth2.repository;

import com.ewatts.auth2.entity.OtpToken;
import com.ewatts.auth2.entity.OtpType;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface OtpTokenRepository extends JpaRepository<OtpToken, Long> {
    Optional<OtpToken> findByEmailAndOtpCodeAndTypeAndUsedFalseAndExpiresAtAfter(
            String email, String otpCode, OtpType type, LocalDateTime now);

    @Modifying
    @Query("DELETE FROM OtpToken o WHERE o.expiresAt < :now")
    void deleteExpiredTokens(LocalDateTime now);

    @Modifying
    @Query("UPDATE OtpToken o SET o.used = true WHERE o.email = :email AND o.type = :type")
    void markAllAsUsedByEmailAndType(String email, OtpType type);

    void deleteAllByEmailAndType(String email, OtpType otpType);

    Optional<OtpToken> findTopByEmailAndTypeOrderByCreatedAtDesc(String email, OtpType otpType);
}
