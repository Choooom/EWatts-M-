package com.ewatts.electricalreadings.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SSRControlRequest {
    @NotNull(message = "SSR state is required")
    private Boolean enabled; // true = ON, false = OFF
}
