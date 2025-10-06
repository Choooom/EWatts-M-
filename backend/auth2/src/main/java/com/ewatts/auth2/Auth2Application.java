package com.ewatts.auth2;

import com.ewatts.auth2.config.OAuthConfig;
import com.ewatts.auth2.entity.User;
import com.ewatts.auth2.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
@EnableDiscoveryClient
@EnableAsync
@EnableScheduling
public class Auth2Application {

	public static void main(String[] args) {
		SpringApplication.run(Auth2Application.class, args);
	}

	@Bean
	CommandLineRunner initAdmin(UserRepository userRepository, PasswordEncoder encoder) {
		return args -> {
			if (userRepository.findByEmail("admin@example.com").isEmpty()) {
				User admin = new User();
				admin.setUsername("admin");
				admin.setEmail("admin@example.com");
				admin.setPassword(encoder.encode("admin123"));
				admin.setEmailVerified(true);
				admin.setRole("ADMIN");
				userRepository.save(admin);
				System.out.println("✅ Default admin account created: admin@example.com / admin123");
			}
		};
	}
}
