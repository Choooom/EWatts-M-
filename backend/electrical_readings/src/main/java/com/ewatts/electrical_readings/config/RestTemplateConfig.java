package com.ewatts.electrical_readings.config;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

    @Bean
    @LoadBalanced // This lets RestTemplate resolve Eureka service IDs
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
