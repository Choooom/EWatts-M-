package com.example.solar.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class OtpService {

    private final JavaMailSender mailSender;
    private final Map<String, OtpEntry> otpStorage = new ConcurrentHashMap<>();

    @Autowired
    public OtpService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendOtp(String recipientEmail) {
        String otp = generateOtp();
        otpStorage.put(recipientEmail, new OtpEntry(otp, LocalDateTime.now()));

        // Hosted logo image (e.g., from Imgur, your website, etc.)
        String logoUrl = "https://i.imgur.com/usWHBRe.png"; // ← replace with your uploaded logo

        String messageBody = String.format("""

                          %s
                      MVT SOLARIZE


        Hello,

        You recently requested to reset your password.
        Please use the following One-Time Password (OTP):

            🔐 OTP Code: %s

        ⚠️ This OTP will expire in 5 minutes.

        Do not share this code with anyone.

        ————————————————————————————————
        ⚠️ Note:
        If you did not request a password reset, you can ignore this email.

        For help or support, visit:
        👉 https://yourdomain.com/support

        📬 Do not reply to this email. This inbox is not monitored.

        © 2025 MVT Solarize. All rights reserved.
        """, logoUrl, otp);

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(recipientEmail);
        message.setSubject("🔐 Your OTP Code - MVT Solarize");
        message.setText(messageBody);
        message.setFrom("arcadiojrflocarencia@gmail.com");

        mailSender.send(message);
    }

    public boolean verifyOtp(String email, String otp) {
        OtpEntry entry = otpStorage.get(email);

        if (entry == null) return false;

        if (LocalDateTime.now().isAfter(entry.timestamp.plusMinutes(5))) {
            otpStorage.remove(email); // clean up expired
            return false;
        }

        return otp.equals(entry.otp);
    }

    private String generateOtp() {
        return String.valueOf(100000 + new Random().nextInt(900000)); // 6-digit OTP
    }

    private static class OtpEntry {
        private final String otp;
        private final LocalDateTime timestamp;

        public OtpEntry(String otp, LocalDateTime timestamp) {
            this.otp = otp;
            this.timestamp = timestamp;
        }
    }
}
