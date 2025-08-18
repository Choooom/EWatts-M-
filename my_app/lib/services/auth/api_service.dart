import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/models/auth/api_response.dart';
import 'package:my_app/models/auth/auth_requests.dart';
import 'package:my_app/models/auth/jwt_response.dart';
import 'package:my_app/models/auth/user_dto.dart';
import 'package:my_app/constants/consts.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiService {
  static const String baseUrl = base_url;
  static const Duration timeout = Duration(seconds: 30);

  String? _accessToken;
  String? _refreshToken;

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  void setTokens(String? accessToken, String? refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
  };

  Future<T> _makeRequest<T>(
    String method,
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? body,
    bool requiresAuth = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    try {
      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: _headers).timeout(timeout);
          break;
        case 'POST':
          response = await http
              .post(
                uri,
                headers: _headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(timeout);
          break;
        case 'PUT':
          response = await http
              .put(
                uri,
                headers: _headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(timeout);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: _headers).timeout(timeout);
          break;
        default:
          throw ApiException('Unsupported HTTP method: $method');
      }

      return _handleResponse<T>(response, fromJson);
    } on SocketException {
      throw ApiException('No internet connection');
    } on HttpException {
      throw ApiException('HTTP error occurred');
    } on FormatException {
      throw ApiException('Invalid response format');
    } catch (e) {
      throw ApiException('Request failed: $e');
    }
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final Map<String, dynamic> jsonResponse;

    try {
      jsonResponse = jsonDecode(response.body);
    } catch (e) {
      throw ApiException('Invalid JSON response');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return fromJson(jsonResponse);
    } else {
      final message = jsonResponse['message'] ?? 'Unknown error occurred';
      throw ApiException(message, response.statusCode);
    }
  }

  // Auth endpoints
  Future<ApiResponse> signUp(SignUpRequest request) async {
    return _makeRequest<ApiResponse>(
      'POST',
      '/api/auth/signup',
      (json) => ApiResponse.fromJson(json, null),
      body: request.toJson(),
    );
  }

  Future<ApiResponse> resendOtp(ResendOtpRequest request) async {
    return _makeRequest<ApiResponse>(
      'POST',
      '/api/auth/resend-otp',
      (json) => ApiResponse.fromJson(json, null),
      body: request.toJson(),
    );
  }

  Future<JwtResponse> verifyEmail(EmailVerificationRequest request) async {
    return _makeRequest<JwtResponse>(
      'POST',
      '/api/auth/verify-email',
      (json) => JwtResponse.fromJson(json),
      body: request.toJson(),
    );
  }

  // Forgot password - request reset
  Future<ApiResponse> requestResetPassword(
    ForgotPasswordRequest request,
  ) async {
    return _makeRequest<ApiResponse>(
      'POST',
      '/api/auth/request-reset-password',
      (json) => ApiResponse.fromJson(json, null),
      body: request.toJson(),
    );
  }

  // Verify OTP for reset
  Future<ApiResponse> verifyResetOtp(VerifyOtpRequest request) async {
    return _makeRequest<ApiResponse>(
      'POST',
      '/api/auth/verify-reset-otp',
      (json) => ApiResponse.fromJson(json, (data) => data as String),
      body: request.toJson(),
    );
  }

  // Set new password
  Future<ApiResponse> setNewPassword(SetNewPasswordRequest request) async {
    return _makeRequest<ApiResponse>(
      'POST',
      '/api/auth/set-new-password',
      (json) => ApiResponse.fromJson(json, (data) => data),
      body: request.toJson(),
    );
  }

  Future<JwtResponse> login(LoginRequest request) async {
    return _makeRequest<JwtResponse>(
      'POST',
      '/api/auth/login',
      (json) => JwtResponse.fromJson(json),
      body: request.toJson(),
    );
  }

  Future<JwtResponse> refreshTokens(RefreshTokenRequest request) async {
    return _makeRequest<JwtResponse>(
      'POST',
      '/api/auth/refresh-token',
      (json) => JwtResponse.fromJson(json),
      body: request.toJson(),
    );
  }

  // User endpoints
  Future<ApiResponse<UserDto>> getUserProfile() async {
    return _makeRequest<ApiResponse<UserDto>>(
      'GET',
      '/api/user/profile',
      (json) => ApiResponse.fromJson(
        json,
        (data) => UserDto.fromJson(data as Map<String, dynamic>),
      ),
      requiresAuth: true,
    );
  }

  Future<ApiResponse<UserDto>> updateProfilePicture(
    String profilePictureUrl,
  ) async {
    return _makeRequest<ApiResponse<UserDto>>(
      'PUT',
      '/api/user/profile-picture?profilePictureUrl=${Uri.encodeComponent(profilePictureUrl)}',
      (json) => ApiResponse.fromJson(
        json,
        (data) => UserDto.fromJson(data as Map<String, dynamic>),
      ),
      requiresAuth: true,
    );
  }

  Future<ApiResponse> testAuth() async {
    return _makeRequest<ApiResponse>(
      'GET',
      '/api/user/test',
      (json) => ApiResponse.fromJson(json, null),
      requiresAuth: true,
    );
  }

  Future<ApiResponse> logout(String refreshToken) async {
    return _makeRequest<ApiResponse>(
      'POST',
      '/api/auth/logout',
      (json) => ApiResponse.fromJson(json, null),
      body: {"refreshToken": refreshToken},
      requiresAuth: true,
    );
  }
}
