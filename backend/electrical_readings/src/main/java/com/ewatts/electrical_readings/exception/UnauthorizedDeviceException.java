package com.ewatts.electrical_readings.exception;

public class UnauthorizedDeviceException extends RuntimeException {
    public UnauthorizedDeviceException(String message) {
        super(message);
    }
}
