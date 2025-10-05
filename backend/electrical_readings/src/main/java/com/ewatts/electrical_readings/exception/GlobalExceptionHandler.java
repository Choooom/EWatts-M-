package com.ewatts.electrical_readings.exception;

import com.ewatts.electrical_readings.dto.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(DeviceNotFoundException.class)
    public ResponseEntity<ApiResponse<String>> handleDeviceNotFound(DeviceNotFoundException e) {
        return ResponseEntity.notFound()
                .build();
    }

    @ExceptionHandler(UnauthorizedDeviceException.class)
    public ResponseEntity<ApiResponse<String>> handleUnauthorizedDevice(UnauthorizedDeviceException e) {
        return ResponseEntity.status(403)
                .body(new ApiResponse<>(false, e.getMessage(), null));
    }

    @ExceptionHandler(InvalidReadingException.class)
    public ResponseEntity<ApiResponse<String>> handleInvalidReading(InvalidReadingException e) {
        return ResponseEntity.badRequest()
                .body(new ApiResponse<>(false, e.getMessage(), null));
    }
}
