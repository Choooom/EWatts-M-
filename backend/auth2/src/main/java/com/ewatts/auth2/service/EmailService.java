package com.ewatts.auth2.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailService {

    private final JavaMailSender mailSender;

    @Value("${app.email.from}")
    private String fromEmail;

    public void sendVerificationEmail(String toEmail, String otpCode, String username) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("Email Verification - Your OTP Code");
            message.setText(buildVerificationEmailBody(username, otpCode));

            mailSender.send(message);
            log.info("Verification email sent successfully to: {}", toEmail);
        } catch (Exception e) {
            log.error("Failed to send verification email to: {}", toEmail, e);
            throw new RuntimeException("Failed to send verification email");
        }
    }

    public void sendPasswordResetEmail(String toEmail, String otpCode, String username) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("Password Reset - Your OTP Code");
            message.setText(buildPasswordResetEmailBody(username, otpCode));

            mailSender.send(message);
            log.info("Password reset email sent successfully to: {}", toEmail);
        } catch (Exception e) {
            log.error("Failed to send password reset email to: {}", toEmail, e);
            throw new RuntimeException("Failed to send password reset email");
        }
    }

    private String buildVerificationEmailBody(String username, String otpCode) {
        return String.format(
                "Hello %s,\n\n" +
                        "Thank you for signing up! Please use the following OTP code to verify your email address:\n\n" +
                        "OTP Code: %s\n\n" +
                        "This code will expire in 5 minutes.\n\n" +
                        "If you didn't create an account, please ignore this email.\n\n" +
                        "Best regards,\n" +
                        "EWatts Team",
                username, otpCode
        );
    }

    private String buildPasswordResetEmailBody(String username, String otpCode) {
        return String.format(
                "Hello %s,\n\n" +
                        "You have requested to reset your password. Please use the following OTP code:\n\n" +
                        "OTP Code: %s\n\n" +
                        "This code will expire in 5 minutes.\n\n" +
                        "If you didn't request a password reset, please ignore this email.\n\n" +
                        "Best regards,\n" +
                        "EWatts Team",
                username, otpCode
        );
    }
}
