import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/models/auth/sign_up_request.dart';

class AuthApi {
  final String baseUrl;

  AuthApi(this.baseUrl);

  Future<void> signup(SignupRequest req) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Signup failed: ${response.body}');
    }
  }

  Future<void> verifyEmail(VerifyOtpRequest req) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Email verification failed: ${response.body}');
    }
  }

  Future<AuthResponse> login(LoginRequest req) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<void> forgotPassword(ForgotPasswordRequest req) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Forgot password failed: ${response.body}');
    }
  }

  Future<void> resetPassword(ResetPasswordRequest req) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Reset password failed: ${response.body}');
    }
  }
}
