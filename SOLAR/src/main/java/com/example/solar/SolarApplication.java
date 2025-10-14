package com.example.solar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class SolarApplication {

    private static final Logger logger = LoggerFactory.getLogger(SolarApplication.class);

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(SolarApplication.class);

        // Optional: disable Spring banner if you want a cleaner console
        app.setBannerMode(Banner.Mode.CONSOLE);

        try {
            logger.info("🚀 Starting Solar Application...");
            ConfigurableApplicationContext context = app.run(args);

            logger.info("✅ Solar Application started successfully!");
            logger.info("📦 Total loaded beans: {}", context.getBeanDefinitionCount());
            logger.info("🟢 Active profiles: {}", String.join(", ", context.getEnvironment().getActiveProfiles()));
            logger.info("🌍 Server running at http://localhost:{}",
                    context.getEnvironment().getProperty("server.port", "8080"));

        } catch (Exception e) {
            logger.error("❌ Failed to start Solar Application: {}", e.getMessage(), e);
            System.exit(1);
        }
    }
}
