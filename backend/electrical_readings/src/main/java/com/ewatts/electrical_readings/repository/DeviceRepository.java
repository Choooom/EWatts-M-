package com.ewatts.electrical_readings.repository;

import com.ewatts.electrical_readings.entity.Device;
import com.ewatts.electrical_readings.entity.DeviceStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface DeviceRepository extends JpaRepository<Device, UUID> {
    Optional<Device> findByDeviceId(String deviceId);
    List<Device> findByStatus(DeviceStatus status);

    @Query("SELECT d FROM Device d WHERE d.location LIKE %:location%")
    List<Device> findByLocationContaining(String location);
}
