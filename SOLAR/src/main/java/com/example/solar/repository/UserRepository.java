package com.example.solar.repository;

import com.example.solar.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    // ✅ Find a user by email (used for login)
    Optional<User> findByEmail(String email);

    // ✅ Get all users with a specific role (e.g., "USER" or "ADMIN")
    List<User> findByRole(String role);

    // ✅ Get all users in a specific location
    List<User> findByLocation(String location);
}
