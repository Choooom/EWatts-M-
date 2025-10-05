package com.ewatts.electrical_readings;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.socket.config.annotation.EnableWebSocket;

@SpringBootApplication
@EnableWebSocket
@EnableScheduling
@EnableDiscoveryClient
public class ElectricalReadingsApplication {

	public static void main(String[] args) {
		SpringApplication.run(ElectricalReadingsApplication.class, args);
	}

}
