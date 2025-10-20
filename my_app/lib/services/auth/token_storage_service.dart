import 'dart:convert';

import 'package:my_app/models/auth/jwt_response.dart';
import 'package:my_app/models/auth/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _tokenTypeKey = 'token_type';
  static const String _expiresInKey = 'expires_in';
  static const String _tokenSavedAtKey = 'token_saved_at';

  static final TokenStorageService _instance = TokenStorageService._internal();
  factory TokenStorageService() => _instance;
  TokenStorageService._internal();

  Future<void> saveTokens(JwtResponse jwtResponse) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, jwtResponse.accessToken);
    await prefs.setString(_refreshTokenKey, jwtResponse.refreshToken);
    await prefs.setString(_tokenTypeKey, jwtResponse.tokenType);
    await prefs.setInt(_expiresInKey, jwtResponse.expiresIn);
    await prefs.setString(_userDataKey, jsonEncode(jwtResponse.user.toJson()));
    await prefs.setInt(_tokenSavedAtKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<UserDto?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);

    if (userDataString != null) {
      final Map<String, dynamic> userJson = jsonDecode(userDataString);
      return UserDto.fromJson(userJson);
    }

    return null;
  }

  Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAt = prefs.getInt(_tokenSavedAtKey);
    final expiresIn = prefs.getInt(_expiresInKey);

    if (savedAt == null || expiresIn == null) {
      return true;
    }

    final savedAtTime = DateTime.fromMillisecondsSinceEpoch(savedAt);
    final expiryTime = savedAtTime.add(Duration(milliseconds: expiresIn));

    // Add a 30-second buffer before actual expiry
    return DateTime.now().isAfter(
      expiryTime.subtract(const Duration(seconds: 30)),
    );
  }

  Future<bool> hasValidTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final isExpired = await isTokenExpired();

    return accessToken != null && refreshToken != null && !isExpired;
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userDataKey);
    await prefs.remove(_tokenTypeKey);
    await prefs.remove(_expiresInKey);
    await prefs.remove(_tokenSavedAtKey);
  }

  Future<JwtResponse?> getStoredJwtResponse() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final userData = await getUserData();
    final prefs = await SharedPreferences.getInstance();
    final tokenType = prefs.getString(_tokenTypeKey);
    final expiresIn = prefs.getInt(_expiresInKey);

    if (accessToken != null &&
        refreshToken != null &&
        userData != null &&
        tokenType != null &&
        expiresIn != null) {
      return JwtResponse(
        accessToken: accessToken,
        refreshToken: refreshToken,
        tokenType: tokenType,
        expiresIn: expiresIn,
        user: userData,
      );
    }

    return null;
  }

  getTokenSync() {}
}
