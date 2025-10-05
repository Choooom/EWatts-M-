package com.ewatts.electrical_readings.repository;

import com.ewatts.electrical_readings.entity.UserDeviceAssignment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserDeviceAssignmentRepository extends JpaRepository<UserDeviceAssignment, UUID> {
    List<UserDeviceAssignment> findByUserIdAndActive(UUID userId, boolean active);
    List<UserDeviceAssignment> findByDeviceIdAndActive(UUID deviceId, boolean active);
    Optional<UserDeviceAssignment> findByUserIdAndDeviceIdAndActive(UUID userId, UUID deviceId, boolean active);
}
