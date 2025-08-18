package com.ewatts.auth2.service;

import org.springframework.stereotype.Service;
import java.security.SecureRandom;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class OtpService {

    private static final String DIGITS = "0123456789";
    private static final int OTP_LENGTH = 6;
    private final SecureRandom random = new SecureRandom();
    private final Map<String, String> resetTokens = new ConcurrentHashMap<>();


    public String generateOtp() {
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(DIGITS.charAt(random.nextInt(DIGITS.length())));
        }
        return otp.toString();
    }

    public void storeResetToken(String email, String token) {
        resetTokens.put(email, token);
    }

    public boolean isValidResetToken(String email, String token) {
        return token != null && token.equals(resetTokens.get(email));
    }

    public void invalidateResetToken(String email) {
        resetTokens.remove(email);
    }
}
