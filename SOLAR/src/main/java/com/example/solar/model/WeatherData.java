package com.example.solar.model;

import jakarta.persistence.*;

@Entity
@Table(name = "weather")
public class WeatherData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int year;
    private int month;
    private int day;

    private float rainfall;
    private float tmax;
    private float tmin;

    private double rh;

    @Column(name = "wind_speed")
    private float windSpeed;

    @Column(name = "wind_direction")
    private int windDirection;

    private String location;

    // Getters and setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public int getMonth() { return month; }
    public void setMonth(int month) { this.month = month; }

    public int getDay() { return day; }
    public void setDay(int day) { this.day = day; }

    public float getRainfall() { return rainfall; }
    public void setRainfall(float rainfall) { this.rainfall = rainfall; }

    public float getTmax() { return tmax; }
    public void setTmax(float tmax) { this.tmax = tmax; }

    public float getTmin() { return tmin; }
    public void setTmin(float tmin) { this.tmin = tmin; }

    public double getRh() { return rh; }
    public void setRh(double rh) { this.rh = rh; }

    public float getWindSpeed() { return windSpeed; }
    public void setWindSpeed(float windSpeed) { this.windSpeed = windSpeed; }

    public int getWindDirection() { return windDirection; }
    public void setWindDirection(int windDirection) { this.windDirection = windDirection; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}
