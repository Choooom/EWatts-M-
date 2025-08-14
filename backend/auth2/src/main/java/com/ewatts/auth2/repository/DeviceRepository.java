package com.ewatts.auth2.repository;

import com.ewatts.auth2.entity.Device;
import com.ewatts.auth2.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DeviceRepository extends JpaRepository<Device, Long> {
    List<Device> findByUser(User user);
    Optional<Device> findByDeviceId(String deviceId);
    List<Device> findByUserAndActive(User user, boolean active);
}
