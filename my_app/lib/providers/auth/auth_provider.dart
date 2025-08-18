// State classes
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/auth/auth_requests.dart';
import 'package:my_app/models/auth/user_dto.dart';
import 'package:my_app/repository/auth/auth_repository.dart';
import 'package:my_app/services/auth/api_service.dart';
import 'package:my_app/services/auth/token_storage_service.dart';

class AuthState {
  final bool isAuthenticated;
  final UserDto? user;
  final bool isLoading;
  final String? error;
  final String? resetToken;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = false,
    this.error,
    this.resetToken,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserDto? user,
    bool? isLoading,
    String? error,
    String? resetToken,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      resetToken: resetToken ?? this.resetToken,
    );
  }

  factory AuthState.initial() => const AuthState();
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final TokenStorageService _tokenStorage;
  final AuthRepository _authRepository;

  AuthNotifier(this._apiService, this._tokenStorage, this._authRepository)
    : super(const AuthState()) {
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    state = state.copyWith(isLoading: true);

    try {
      final hasValidTokens = await _tokenStorage.hasValidTokens();

      if (hasValidTokens) {
        final jwtResponse = await _tokenStorage.getStoredJwtResponse();
        if (jwtResponse != null) {
          _apiService.setTokens(
            jwtResponse.accessToken,
            jwtResponse.refreshToken,
          );
          state = state.copyWith(
            isAuthenticated: true,
            user: jwtResponse.user,
            isLoading: false,
          );
          return;
        }
      }

      // Try to refresh token if available
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken != null) {
        await _refreshToken(refreshToken);
      } else {
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> signUp(SignUpRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.signUp(request);
      state = state.copyWith(isLoading: false);

      if (!response.success) {
        state = state.copyWith(error: response.message);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }

    return true;
  }

  Future<bool> resendOtp(ResendOtpRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.resendOtp(request);
      state = state.copyWith(isLoading: false);

      if (!response.success) {
        state = state.copyWith(error: response.message);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }

    return true;
  }

  Future<bool> verifyEmail(EmailVerificationRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.verifyEmail(request);

      await _tokenStorage.saveTokens(response);
      _apiService.setTokens(response.accessToken, response.refreshToken);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.login(request);

      await _tokenStorage.saveTokens(response);
      _apiService.setTokens(response.accessToken, response.refreshToken);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print("Error message: ${e}");
      print("Error auth state message: ${state.error}");
    }
  }

  Future<void> _refreshToken(String refreshToken) async {
    try {
      final response = await _apiService.refreshTokens(
        RefreshTokenRequest(refreshToken: refreshToken),
      );

      await _tokenStorage.saveTokens(response);
      _apiService.setTokens(response.accessToken, response.refreshToken);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        isLoading: false,
      );
    } catch (e) {
      await logout();
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authRepository.logout();
      state = AuthState.initial();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> checkAuthOnStartup() async {
    final tokens = await _tokenStorage.getRefreshToken();

    if (tokens != null) {
      await _refreshToken(tokens);
    } else {
      await logout();
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authRepository.requestResetPassword(email: email);
      if (!response.success) {
        state = state.copyWith(error: response.message);
        return false;
      }
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> verifyPasswordResetOtp(String email, String otpCode) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authRepository.verifyResetOtp(
        email: email,
        otpCode: otpCode,
      );

      if (!response.success) {
        state = state.copyWith(error: response.message);
        return false;
      } else {
        final resetToken = response.data as String?;
        state = state.copyWith(resetToken: resetToken);
        return true;
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> setNewPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _authRepository.setNewPassword(
        email: email,
        resetToken: resetToken,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (!response.success) {
        state = state.copyWith(error: response.message);
        return false;
      } else {
        state = state.copyWith(error: null, isLoading: false, resetToken: null);
        return true;
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateProfilePicture(String profilePictureUrl) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.updateProfilePicture(
        profilePictureUrl,
      );

      if (response.success && response.data != null) {
        state = state.copyWith(user: response.data, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, error: response.message);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Providers
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final tokenStorageProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(apiServiceProvider),
    ref.read(tokenStorageProvider),
  );
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(apiServiceProvider),
    ref.read(tokenStorageProvider),
    ref.read(authRepositoryProvider),
  );
});

// Computed providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final currentUserProvider = Provider<UserDto?>((ref) {
  return ref.watch(authProvider).user;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).error;
});
