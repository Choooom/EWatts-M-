/*
package com.example.solar.controller;

import com.example.solar.payload.LoginRequest;
import com.example.solar.payload.SignupRequest;
import com.example.solar.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "http://localhost:3000")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        String role = authService.login(request.getEmail(), request.getPassword());
        return ResponseEntity.ok(Collections.singletonMap("role", role));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody SignupRequest request) {
        authService.signup(request.getEmail(), request.getPassword());
        return ResponseEntity.ok("User created");
    }
}
*/

package com.example.solar.controller;

import com.example.solar.payload.LoginRequest;
import com.example.solar.payload.SignupRequest;
import com.example.solar.service.AuthService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "http://localhost:3000")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        try {
            String role = authService.login(request.getEmail(), request.getPassword());

            Map<String, Object> response = new HashMap<>();
            response.put("role", role);
            response.put("email", request.getEmail());
            response.put("message", "Login successful");

            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody SignupRequest request) {
        try {
            authService.signup(request.getEmail(), request.getPassword());

            Map<String, String> response = new HashMap<>();
            response.put("message", "User created successfully");
            response.put("email", request.getEmail());

            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (RuntimeException e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        }
    }
}
