import 'package:json_annotation/json_annotation.dart';

part 'auth_requests.g.dart';

@JsonSerializable()
class LoginRequest {
  final String usernameOrEmail;
  final String password;

  LoginRequest({required this.usernameOrEmail, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class SignUpRequest {
  final String username;
  final String email;
  final String? phoneNumber;
  final String password;
  final String? provider;

  SignUpRequest({
    required this.username,
    required this.email,
    this.phoneNumber,
    required this.password,
    this.provider,
  });

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class ResendOtpRequest {
  final String email;
  final String? provider;

  ResendOtpRequest({required this.email, this.provider});

  Map<String, dynamic> toJson() => _$ResendOtpRequestToJson(this);
}

@JsonSerializable()
class EmailVerificationRequest {
  final String email;
  final String otpCode;

  EmailVerificationRequest({required this.email, required this.otpCode});

  Map<String, dynamic> toJson() => _$EmailVerificationRequestToJson(this);
}

@JsonSerializable()
class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

@JsonSerializable()
class VerifyOtpRequest {
  final String email;
  final String otpCode;

  VerifyOtpRequest({required this.email, required this.otpCode});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable()
class SetNewPasswordRequest {
  final String email;
  final String resetToken;
  final String newPassword;
  final String confirmPassword;

  SetNewPasswordRequest({
    required this.email,
    required this.resetToken,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory SetNewPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$SetNewPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetNewPasswordRequestToJson(this);
}

@JsonSerializable()
class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
