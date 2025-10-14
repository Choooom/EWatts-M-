package com.ewatts.electricalreadings;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.integration.annotation.IntegrationComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@IntegrationComponentScan
public class ElectricalReadingsApplication {

	public static void main(String[] args) {
		SpringApplication.run(ElectricalReadingsApplication.class, args);
	}

}
