package com.ewatts.auth2.service;

import org.springframework.stereotype.Service;
import java.security.SecureRandom;

@Service
public class OtpService {

    private static final String DIGITS = "0123456789";
    private static final int OTP_LENGTH = 6;
    private final SecureRandom random = new SecureRandom();

    public String generateOtp() {
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        }
        return otp.toString();
    }
}
