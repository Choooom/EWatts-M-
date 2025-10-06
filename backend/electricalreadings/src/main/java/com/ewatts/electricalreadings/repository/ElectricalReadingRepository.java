package com.ewatts.electricalreadings.repository;

import com.ewatts.electricalreadings.entity.ElectricalReading;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ElectricalReadingRepository extends JpaRepository<ElectricalReading, Long> {

    Page<ElectricalReading> findByDeviceIdOrderByTimestampDesc(Long deviceId, Pageable pageable);

    Page<ElectricalReading> findByUserIdOrderByTimestampDesc(Long userId, Pageable pageable);

    List<ElectricalReading> findByDeviceIdAndTimestampBetweenOrderByTimestampDesc(
            Long deviceId, LocalDateTime start, LocalDateTime end);

    List<ElectricalReading> findByUserIdAndTimestampBetweenOrderByTimestampDesc(
            Long userId, LocalDateTime start, LocalDateTime end);

    @Query("SELECT r FROM ElectricalReading r WHERE r.deviceId = :deviceId " +
            "AND r.timestamp >= :start AND r.timestamp < :end")
    List<ElectricalReading> findReadingsForAggregation(
            @Param("deviceId") Long deviceId,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end);

    ElectricalReading findFirstByDeviceIdOrderByTimestampDesc(Long deviceId);

    void deleteByTimestampBefore(LocalDateTime timestamp);
}