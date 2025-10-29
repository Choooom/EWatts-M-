// lib/config/api_config.dart

class ApiConfig {
  // IMPORTANT: Update these values based on your environment

  // For local development
  static const String localhost = 'http://127.0.0.1:8000';

  // For Android emulator (use this if running on Android emulator)
  static const String androidEmulator = 'https://ewatts.uk';

  // For iOS simulator (use localhost)
  static const String iosSimulator = 'http://localhost:8000';

  // For physical device (replace with your computer's IP address)
  // Find your IP: Windows (ipconfig), Mac/Linux (ifconfig)
  static const String physicalDevice = 'http://192.168.1.100:8000';

  // Production server URL (when deployed)
  static const String production = 'https://api.ewatts.uk';

  // Active configuration - CHANGE THIS based on your setup
  static const String baseUrl =
      androidEmulator; // Change to androidEmulator, physicalDevice, etc.

  // API endpoints
  static const String predictWeather = '/predict-weather';
  static const String predictWeatherFreeAI = '/predict-weather-free-ai';
  static const String health = '/health';

  // Request timeout
  static const Duration timeout = Duration(seconds: 30);

  // Default location (Manila, Philippines)
  static const double defaultLatitude = 14.5995;
  static const double defaultLongitude = 120.9842;
}
