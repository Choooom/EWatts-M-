// signup_request.dart
class SignupRequest {
  final String email;
  final String password;

  SignupRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

// verify_otp_request.dart
class VerifyOtpRequest {
  final String email;
  final String otp;

  VerifyOtpRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

// login_request.dart
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

// auth_response.dart
class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({required this.token, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(token: json['token'], refreshToken: json['refreshToken']);
}

// forgot_password_request.dart
class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

// reset_password_request.dart
class ResetPasswordRequest {
  final String email;
  final String newPassword;
  final String otp;

  ResetPasswordRequest({
    required this.email,
    required this.newPassword,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'newPassword': newPassword,
    'otp': otp,
  };
}
