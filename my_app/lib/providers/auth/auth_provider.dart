import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/consts.dart';
import 'package:my_app/models/auth/sign_up_request.dart';
import 'package:my_app/services/auth/auth_api.dart';

// Provide your AuthApi instance:
final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(baseUrl); // change to your backend URL
});

// Signup StateNotifier
class SignupNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthApi api;

  SignupNotifier(this.api) : super(const AsyncData(null));

  Future<void> signup(SignupRequest req) async {
    state = const AsyncLoading();
    try {
      await api.signup(req);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final signupProvider = StateNotifierProvider<SignupNotifier, AsyncValue<void>>((
  ref,
) {
  final api = ref.watch(authApiProvider);
  return SignupNotifier(api);
});

// Similarly for Login

class LoginNotifier extends StateNotifier<AsyncValue<AuthResponse>> {
  final AuthApi api;

  LoginNotifier(this.api) : super(const AsyncLoading());

  Future<void> login(LoginRequest req) async {
    state = const AsyncLoading();
    try {
      final response = await api.login(req);
      state = AsyncData(response);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<AuthResponse>>((ref) {
      final api = ref.watch(authApiProvider);
      return LoginNotifier(api);
    });

// Forgot Password, Reset Password can have similar notifiers
