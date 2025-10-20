package com.ewatts.electricalreadings.entity;

public enum DeviceType {
    HOUSE_METER,    // Connected to main breaker switch
    APPLIANCE,      // Individual appliances (refrigerator, TV, computer, etc.)
    SOLAR_PANEL,     // DC devices for solar panels
    BATTERY
}