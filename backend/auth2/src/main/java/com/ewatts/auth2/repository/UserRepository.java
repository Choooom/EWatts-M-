package com.ewatts.auth2.repository;

import com.ewatts.auth2.entity.AuthProvider;
import com.ewatts.auth2.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    Optional<User> findByProviderAndProviderId(AuthProvider provider, String providerId);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    boolean existsByPhoneNumber(String phoneNumber);
    List<User> findByRole(String role);

    //for admin
    Page<User> findByUsernameContainingIgnoreCase(String username, Pageable pageable);
    Page<User> findByEmailContainingIgnoreCase(String email, Pageable pageable);
    Page<User> findByProvider(AuthProvider provider, Pageable pageable);
    Page<User> findByRole(String role, Pageable pageable);
    Page<User> findByEmailVerified(boolean emailVerified, Pageable pageable);
    Page<User> findByAccountEnabled(boolean accountEnabled, Pageable pageable);

    long countByEmailVerified(boolean emailVerified);
    long countByAccountEnabled(boolean accountEnabled);
    long countByRole(String role);
    long countByProvider(AuthProvider provider);
    long countByCreatedAtAfter(LocalDateTime date);
}
