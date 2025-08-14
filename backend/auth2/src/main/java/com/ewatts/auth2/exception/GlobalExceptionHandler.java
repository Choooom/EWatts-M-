package com.ewatts.auth2.exception;

import com.ewatts.auth2.dto.ApiResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<ApiResponse> handleBadRequestException(BadRequestException ex) {
        log.error("BadRequestException: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, ex.getMessage());
        return new ResponseEntity<>(apiResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiResponse> handleResourceNotFoundException(ResourceNotFoundException ex) {
        log.error("ResourceNotFoundException: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, ex.getMessage());
        return new ResponseEntity<>(apiResponse, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(OAuth2AuthenticationProcessingException.class)
    public ResponseEntity<ApiResponse> handleOAuth2AuthenticationProcessingException(OAuth2AuthenticationProcessingException ex) {
        log.error("OAuth2AuthenticationProcessingException: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, ex.getMessage());
        return new ResponseEntity<>(apiResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(TokenRefreshException.class)
    public ResponseEntity<ApiResponse> handleTokenRefreshException(TokenRefreshException ex) {
        log.error("TokenRefreshException: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, ex.getMessage());
        return new ResponseEntity<>(apiResponse, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ApiResponse> handleBadCredentialsException(BadCredentialsException ex) {
        log.error("BadCredentialsException: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, "Invalid username/email or password");
        return new ResponseEntity<>(apiResponse, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<ApiResponse> handleUsernameNotFoundException(UsernameNotFoundException ex) {
        log.error("UsernameNotFoundException: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, "User not found");
        return new ResponseEntity<>(apiResponse, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse> handleValidationExceptions(MethodArgumentNotValidException ex) {
        log.error("MethodArgumentNotValidException: ", ex);
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        ApiResponse apiResponse = new ApiResponse(false, "Validation failed", errors);
        return new ResponseEntity<>(apiResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse> handleGenericException(Exception ex) {
        log.error("Unexpected error: ", ex);
        ApiResponse apiResponse = new ApiResponse(false, "An unexpected error occurred. Please try again later.");
        return new ResponseEntity<>(apiResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
