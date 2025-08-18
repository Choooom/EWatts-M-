import 'package:my_app/models/auth/api_response.dart';
import 'package:my_app/models/auth/auth_requests.dart';
import 'package:my_app/models/auth/jwt_response.dart';
import 'package:my_app/models/auth/user_dto.dart';
import 'package:my_app/services/auth/api_service.dart';
import 'package:my_app/services/auth/token_storage_service.dart';

class AuthRepository {
  final ApiService _apiService;
  final TokenStorageService _tokenStorageService;

  AuthRepository(this._apiService, this._tokenStorageService);

  Future<ApiResponse> signUp({
    required String username,
    required String email,
    required String password,
    String? phoneNumber,
    String? provider,
  }) async {
    final request = SignUpRequest(
      username: username,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      provider: provider ?? 'LOCAL',
    );

    return await _apiService.signUp(request);
  }

  Future<JwtResponse> verifyEmail({
    required String email,
    required String otpCode,
  }) async {
    final request = EmailVerificationRequest(email: email, otpCode: otpCode);

    return await _apiService.verifyEmail(request);
  }

  Future<ApiResponse> requestResetPassword({required String email}) async {
    final request = ForgotPasswordRequest(email: email);
    return await _apiService.requestResetPassword(request);
  }

  Future<ApiResponse> verifyResetOtp({
    required String email,
    required String otpCode,
  }) async {
    final request = VerifyOtpRequest(email: email, otpCode: otpCode);

    final response = await _apiService.verifyResetOtp(request);

    return ApiResponse<String>(
      success: response.success,
      message: response.message,
      data: response.data != null ? response.data as String : null,
    );
  }

  Future<ApiResponse> setNewPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final request = SetNewPasswordRequest(
      email: email,
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    final response = await _apiService.setNewPassword(request);

    return response;
  }

  Future<JwtResponse> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    final request = LoginRequest(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    return await _apiService.login(request);
  }

  Future<JwtResponse> refreshToken({required String refreshToken}) async {
    final request = RefreshTokenRequest(refreshToken: refreshToken);
    return await _apiService.refreshTokens(request);
  }

  Future<ApiResponse<UserDto>> getUserProfile() async {
    return await _apiService.getUserProfile();
  }

  Future<ApiResponse<UserDto>> updateProfilePicture({
    required String profilePictureUrl,
  }) async {
    return await _apiService.updateProfilePicture(profilePictureUrl);
  }

  Future<ApiResponse> testAuth() async {
    return await _apiService.testAuth();
  }

  Future<void> logout() async {
    final refreshToken = await _tokenStorageService.getRefreshToken();
    if (refreshToken != null) {
      try {
        await _apiService.logout(refreshToken);
      } catch (e) {
        // Optionally log error, but still proceed with clearing tokens
      }
    }
    await _tokenStorageService.clearTokens();
  }
}
