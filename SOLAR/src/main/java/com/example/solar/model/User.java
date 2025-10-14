/*
package com.example.solar.model;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role; // "ADMIN" or "USER"

    @Column(nullable = false)
    private String location;

    @Column(name = "installation_date")
    private LocalDate installationDate;

    @Column(name = "solar_type")
    private String solarType;

    @Column(name = "wattage")
    private Integer wattage;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "total_wattage")
    private Integer totalWattage;

    @Column(name = "energy_target")
    private Double energyTarget;
}


+++++++++++++++++++++++++++++++++++++++++++++++

package com.example.solar.model;

import jakarta.persistence.*;
import java.time.LocalDate;


@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role; // "ADMIN" or "USER"

    private String username;
    private String location;
    private String solarType;
    private Integer wattage;
    private Integer quantity;
    private Integer totalWattage;
    private LocalDate installationDate;
    private Integer energyTarget; // Monthly target in kWh

    // Default constructor
    public User() {}

    // Constructor for basic auth
    public User(String email, String password, String role) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.username = email.split("@")[0];
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getSolarType() {
        return solarType;
    }

    public void setSolarType(String solarType) {
        this.solarType = solarType;
    }

    public Integer getWattage() {
        return wattage;
    }

    public void setWattage(Integer wattage) {
        this.wattage = wattage;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getTotalWattage() {
        return totalWattage;
    }

    public void setTotalWattage(Integer totalWattage) {
        this.totalWattage = totalWattage;
    }

    public LocalDate getInstallationDate() {
        return installationDate;
    }

    public void setInstallationDate(LocalDate installationDate) {
        this.installationDate = installationDate;
    }

    public Integer getEnergyTarget() {
        return energyTarget;
    }

    public void setEnergyTarget(Integer energyTarget) {
        this.energyTarget = energyTarget;
    }
}
*/

package com.example.solar.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role; // "ADMIN" or "USER"

    private String username;
    private String location;
    private String solarType;
    private Integer wattage;
    private Integer quantity;
    private Integer totalWattage;
    private LocalDate installationDate;
    private Integer energyTarget; // Monthly target in kWh

    // 🔐 OTP for forgot password
    private String otp;

    // ⏰ Time when OTP was requested (for expiration logic)
    private LocalDateTime otpRequestedTime;

    // 🔧 Default constructor
    public User() {}

    public User(String email, String password, String role) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.username = email.split("@")[0];
    }

    // ✅ Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getSolarType() { return solarType; }
    public void setSolarType(String solarType) { this.solarType = solarType; }

    public Integer getWattage() { return wattage; }
    public void setWattage(Integer wattage) { this.wattage = wattage; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Integer getTotalWattage() { return totalWattage; }
    public void setTotalWattage(Integer totalWattage) { this.totalWattage = totalWattage; }

    public LocalDate getInstallationDate() { return installationDate; }
    public void setInstallationDate(LocalDate installationDate) { this.installationDate = installationDate; }

    public Integer getEnergyTarget() { return energyTarget; }
    public void setEnergyTarget(Integer energyTarget) { this.energyTarget = energyTarget; }

    public String getOtp() { return otp; }
    public void setOtp(String otp) { this.otp = otp; }

    public LocalDateTime getOtpRequestedTime() { return otpRequestedTime; }
    public void setOtpRequestedTime(LocalDateTime otpRequestedTime) { this.otpRequestedTime = otpRequestedTime; }
}
