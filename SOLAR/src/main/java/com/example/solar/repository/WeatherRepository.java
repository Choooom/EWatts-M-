package com.example.solar.repository;

import com.example.solar.model.WeatherData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WeatherRepository extends JpaRepository<WeatherData, Long> {

    @Query("SELECT w FROM WeatherData w WHERE LOWER(TRIM(w.location)) = :location AND w.year = :year AND w.month = :month AND w.day = :day")
    Optional<WeatherData> findByLocationAndDate(@Param("location") String location,
                                                @Param("year") int year,
                                                @Param("month") int month,
                                                @Param("day") int day);

    @Query("SELECT w FROM WeatherData w WHERE LOWER(TRIM(w.location)) = :location ORDER BY w.year DESC, w.month DESC, w.day DESC")
    List<WeatherData> findLatestByLocation(@Param("location") String location);

    @Query("SELECT w FROM WeatherData w WHERE LOWER(TRIM(w.location)) = :location AND w.month = :month ORDER BY w.year DESC")
    List<WeatherData> findByLocationAndMonth(@Param("location") String location, @Param("month") int month);


    @Query("SELECT DISTINCT w.location FROM WeatherData w ORDER BY w.location")
    List<String> findDistinctLocations();

    List<WeatherData> findByLocationOrderByYearDescMonthDescDayDesc(String location);

    // ✅ NEW: Fetch all records sorted by date descending
    @Query("SELECT w FROM WeatherData w ORDER BY w.year DESC, w.month DESC, w.day DESC")
    List<WeatherData> findAllOrderedByDateDesc();
}
