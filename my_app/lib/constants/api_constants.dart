class ApiConstants {
  // Change this to your actual backend URL
  static const String baseUrl = 'http://localhost:8080';

  // Auth endpoints
  static const String signupEndpoint = '/api/auth/signup';
  static const String verifyEmailEndpoint = '/api/auth/verify-email';
  static const String loginEndpoint = '/api/auth/login';
  static const String forgotPasswordEndpoint = '/api/auth/forgot-password';
  static const String resetPasswordEndpoint = '/api/auth/reset-password';
  static const String refreshTokenEndpoint = '/api/auth/refresh-token';

  // User endpoints
  static const String userProfileEndpoint = '/api/user/profile';
  static const String updateProfilePictureEndpoint =
      '/api/user/profile-picture';
  static const String testAuthEndpoint = '/api/user/test';

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
}
