package com.example.solar.service;

import com.example.solar.model.User;
import com.example.solar.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // 🔐 LOGIN
    public String login(String email, String password) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Invalid password");
        }

        return user.getRole(); // ADMIN or USER
    }

    // ✍️ SIGNUP
    public void signup(String email, String password) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("Email already in use");
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole("USER");
        user.setUsername(email.split("@")[0]);
        userRepository.save(user);
    }

    // ✅ ADMIN-SIDE CREATE
    public User createUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("USER");
        return userRepository.save(user);
    }

    // 🔍 GET all customers (role = USER)
    public List<User> getAllCustomers() {
        return userRepository.findByRole("USER");
    }

    // 🔍 GET by ID
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    // 🔍 GET by location
    public List<User> getUsersByLocation(String location) {
        return userRepository.findByLocation(location);
    }

    // 🛠️ UPDATE user
    public User updateUser(Long id, User updatedUser) {
        return userRepository.findById(id).map(user -> {
            user.setUsername(updatedUser.getUsername());
            user.setEmail(updatedUser.getEmail());
            user.setLocation(updatedUser.getLocation());
            user.setSolarType(updatedUser.getSolarType());
            user.setWattage(updatedUser.getWattage());
            user.setQuantity(updatedUser.getQuantity());
            user.setTotalWattage(updatedUser.getTotalWattage());
            user.setInstallationDate(updatedUser.getInstallationDate());
            user.setEnergyTarget(updatedUser.getEnergyTarget());
            return userRepository.save(user);
        }).orElseThrow(() -> new RuntimeException("User not found"));
    }

    // ❌ DELETE user
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    // 🔐 GENERATE AND STORE OTP
    public String generateAndStoreOtp(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        String otp = String.format("%06d", new Random().nextInt(900000) + 100000); // Safer 6-digit
        user.setOtp(otp);
        user.setOtpRequestedTime(LocalDateTime.now());
        userRepository.save(user);
        return otp;
    }

    // ✅ VERIFY OTP
    public boolean verifyOtp(String email, String submittedOtp) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (user.getOtp() == null || user.getOtpRequestedTime() == null) {
            return false;
        }

        LocalDateTime now = LocalDateTime.now();
        if (now.isAfter(user.getOtpRequestedTime().plusMinutes(10))) {
            return false; // Expired
        }

        return submittedOtp.equals(user.getOtp());
    }

    // 🔄 RESET PASSWORD
    @Transactional
    public void resetPassword(String email, String newPassword) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        user.setPassword(passwordEncoder.encode(newPassword));
        user.setOtp(null);
        user.setOtpRequestedTime(null);
        userRepository.save(user);
    }
}
