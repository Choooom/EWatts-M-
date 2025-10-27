package com.ewatts.electricalreadings.repository;

import com.ewatts.electricalreadings.entity.AggregatedReading;
import com.ewatts.electricalreadings.entity.AggregationType;
import com.ewatts.electricalreadings.entity.DeviceType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface AggregatedReadingRepository extends JpaRepository<AggregatedReading, Long> {

    List<AggregatedReading> findByDeviceIdAndAggregationTypeOrderByPeriodStartDesc(
            Long deviceId, AggregationType type);

    List<AggregatedReading> findByUserIdAndAggregationTypeOrderByPeriodStartDesc(
            Long userId, AggregationType type);

    List<AggregatedReading> findByDeviceIdAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
            Long deviceId, AggregationType type, LocalDateTime start, LocalDateTime end);

    List<AggregatedReading> findByUserIdAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
            Long userId, AggregationType type, LocalDateTime start, LocalDateTime end);

    Optional<AggregatedReading> findByDeviceIdAndAggregationTypeAndPeriodStart(
            Long deviceId, AggregationType type, LocalDateTime periodStart);

    @Query("SELECT SUM(a.totalEnergyConsumed) FROM AggregatedReading a " +
            "WHERE a.deviceId = :deviceId AND a.aggregationType = :type " +
            "AND a.periodStart >= :start AND a.periodStart < :end")
    Double getTotalEnergyForPeriod(
            @Param("deviceId") Long deviceId,
            @Param("type") AggregationType type,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end);

    // NEW METHODS FOR DEVICE TYPE QUERIES
    List<AggregatedReading> findByUserIdAndDeviceTypeAndAggregationTypeOrderByPeriodStartDesc(
            Long userId, DeviceType deviceType, AggregationType type);

    List<AggregatedReading> findByUserIdAndDeviceTypeAndAggregationTypeAndPeriodStartBetweenOrderByPeriodStartDesc(
            Long userId, DeviceType deviceType, AggregationType type,
            LocalDateTime start, LocalDateTime end);

    Optional<AggregatedReading> findByUserIdAndDeviceTypeAndAggregationTypeAndPeriodStart(
            Long userId, DeviceType deviceType, AggregationType type, LocalDateTime periodStart);

    // NEW ENERGY CALCULATION QUERIES
    @Query("SELECT SUM(a.totalEnergyConsumed) FROM AggregatedReading a " +
            "WHERE a.userId = :userId AND a.deviceType = :deviceType " +
            "AND a.aggregationType = :type " +
            "AND a.periodStart >= :start AND a.periodStart < :end")
    Double getTotalEnergyByDeviceType(
            @Param("userId") Long userId,
            @Param("deviceType") DeviceType deviceType,
            @Param("type") AggregationType type,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end);

    @Query("SELECT SUM(a.totalEnergyConsumed) FROM AggregatedReading a " +
            "WHERE a.deviceId = :deviceId AND a.aggregationType = :type " +
            "AND a.periodStart >= :start AND a.periodStart < :end")
    Double getTotalEnergyForDevice(
            @Param("deviceId") Long deviceId,
            @Param("type") AggregationType type,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end);
}