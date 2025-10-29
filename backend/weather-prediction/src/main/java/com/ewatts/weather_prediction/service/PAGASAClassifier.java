package com.ewatts.weather_prediction.service;

import org.springframework.stereotype.Component;

@Component
public class PAGASAClassifier {

    public String classifyClouds(double percent) {
        if (percent <= 10) return "Clear or Sunny Skies";
        else if (percent <= 25) return "Partly Cloudy";
        else if (percent <= 50) return "Partly Cloudy to at Times Cloudy";
        else if (percent <= 75) return "Mostly or Mainly Cloudy";
        else if (percent <= 90) return "Cloudy";
        else return "Overcast";
    }

    public String classifyWind(double speed) {
        if (speed <= 3.3) return "Light Winds";
        else if (speed <= 7.9) return "Moderate Winds";
        else if (speed <= 10.7) return "Moderate to Occasionally Strong";
        else if (speed <= 13.8) return "Fresh Winds";
        else if (speed <= 17.1) return "Strong Winds";
        else if (speed <= 20.7) return "Near Gale";
        else if (speed <= 24.4) return "Gale";
        else if (speed <= 28.4) return "Strong Gale";
        else if (speed <= 32.6) return "Storm";
        else if (speed <= 36.9) return "Violent Storm";
        else return "Typhoon";
    }

    public String classifyPrecipitation(double precip) {
        if (precip <= 0.1) return "No Precipitation";
        else if (precip <= 2.5) return "Very Light Rains";
        else if (precip <= 10) return "Light Rains";
        else if (precip <= 20) return "Moderate Rains";
        else if (precip <= 50) return "Heavy Rains";
        else return "Monsoon Rains";
    }
}

