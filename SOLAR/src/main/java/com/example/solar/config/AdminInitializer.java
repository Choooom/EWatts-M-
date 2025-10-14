package com.example.solar.config;

import com.example.solar.model.User;
import com.example.solar.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class AdminInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public AdminInitializer(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        String adminEmail = "arcadiojrflocarencia@gmail.com";
        String adminPassword = "Admin123";

        // Check if admin exists
        if (userRepository.findByEmail(adminEmail).isEmpty()) {
            User admin = new User();
            admin.setEmail(adminEmail);
            admin.setPassword(passwordEncoder.encode(adminPassword)); // encode the password
            admin.setRole("ADMIN");

            userRepository.save(admin);
            System.out.println("✅ Admin account created!");
        } else {
            System.out.println("ℹ️ Admin account already exists.");
        }
    }
}
