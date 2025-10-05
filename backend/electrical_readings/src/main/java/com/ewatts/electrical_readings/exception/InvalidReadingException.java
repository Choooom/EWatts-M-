package com.ewatts.electrical_readings.exception;

public class InvalidReadingException extends RuntimeException {
    public InvalidReadingException(String message) {
        super(message);
    }
}
