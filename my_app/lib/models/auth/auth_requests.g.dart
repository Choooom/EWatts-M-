// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  usernameOrEmail: json['usernameOrEmail'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'usernameOrEmail': instance.usernameOrEmail,
      'password': instance.password,
    };

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String,
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'provider': instance.provider,
    };

ResendOtpRequest _$ResendOtpRequestFromJson(Map<String, dynamic> json) =>
    ResendOtpRequest(
      email: json['email'] as String,
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$ResendOtpRequestToJson(ResendOtpRequest instance) =>
    <String, dynamic>{'email': instance.email, 'provider': instance.provider};

EmailVerificationRequest _$EmailVerificationRequestFromJson(
  Map<String, dynamic> json,
) => EmailVerificationRequest(
  email: json['email'] as String,
  otpCode: json['otpCode'] as String,
);

Map<String, dynamic> _$EmailVerificationRequestToJson(
  EmailVerificationRequest instance,
) => <String, dynamic>{'email': instance.email, 'otpCode': instance.otpCode};

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequest(email: json['email'] as String);

Map<String, dynamic> _$ForgotPasswordRequestToJson(
  ForgotPasswordRequest instance,
) => <String, dynamic>{'email': instance.email};

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      email: json['email'] as String,
      otpCode: json['otpCode'] as String,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{'email': instance.email, 'otpCode': instance.otpCode};

SetNewPasswordRequest _$SetNewPasswordRequestFromJson(
  Map<String, dynamic> json,
) => SetNewPasswordRequest(
  email: json['email'] as String,
  resetToken: json['resetToken'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$SetNewPasswordRequestToJson(
  SetNewPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'resetToken': instance.resetToken,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    RefreshTokenRequest(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshTokenRequestToJson(
  RefreshTokenRequest instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};
