package com.ewatts.auth2.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(unique = true, nullable = false)
    private String email;

    private String phoneNumber;

    @Column(nullable = false)
    private String password;

    @Column(name = "is_email_verified")
    private boolean emailVerified = false;

    @Column(name = "is_account_enabled")
    private boolean accountEnabled = true;

    @Enumerated(EnumType.STRING)
    private AuthProvider provider = AuthProvider.LOCAL;

    private String providerId;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Column(name = "profile_picture_url")
    private String profilePictureUrl;


    // Future relationship with devices
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Device> devices;
}

