package com.ewatts.electricalreadings.repository;

import com.ewatts.electricalreadings.entity.ElectricalDevice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ElectricalDeviceRepository extends JpaRepository<ElectricalDevice, Long> {

    Optional<ElectricalDevice> findByDeviceToken(String deviceToken);

    Optional<ElectricalDevice> findByEsp32Id(String esp32Id);

    List<ElectricalDevice> findByUserId(Long userId);

    List<ElectricalDevice> findByUserIdAndActive(Long userId, Boolean active);

    boolean existsByEsp32Id(String esp32Id);

    boolean existsByDeviceToken(String deviceToken);
}