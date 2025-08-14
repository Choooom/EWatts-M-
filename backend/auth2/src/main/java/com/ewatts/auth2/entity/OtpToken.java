package com.ewatts.auth2.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "otp_tokens")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OtpToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String otpCode;

    @Enumerated(EnumType.STRING)
    private OtpType type;

    @Column(nullable = false)
    private LocalDateTime expiresAt;

    @Column(name = "is_used")
    private boolean used = false;

    @CreationTimestamp
    private LocalDateTime createdAt;
}

