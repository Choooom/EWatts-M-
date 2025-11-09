package com.ewatts.auth2.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserStatsDto {
    private long totalUsers;
    private long verifiedUsers;
    private long unverifiedUsers;
    private long enabledUsers;
    private long disabledUsers;
    private long totalAdmins;
    private long totalRegularUsers;
    private Map<String, Long> usersByProvider;
    private long usersCreatedToday;
    private long usersCreatedThisWeek;
    private long usersCreatedThisMonth;
}