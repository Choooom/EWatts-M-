import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/widgets/oauth_webview.dart';
import 'package:my_app/constants/consts.dart';
import 'package:app_links/app_links.dart'; // Add this dependency

class OAuthService {
  static const String baseUrl = base_url; // Update with your actual URL

  // Step 1: Get OAuth URL from backend
  Future<String> getOAuthUrl(String provider) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/oauth/$provider/url'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['authUrl'];
    } else {
      throw Exception('Failed to get OAuth URL');
    }
  }

  // Step 2: Exchange authorization code for JWT (fallback method)
  Future<Map<String, dynamic>> loginWithOAuth(
    String provider,
    String code,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/oauth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'provider': provider, 'code': code}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('OAuth login failed: ${response.body}');
    }
  }
}

class OAuthManager {
  static final OAuthManager _instance = OAuthManager._internal();
  factory OAuthManager() => _instance;
  OAuthManager._internal();

  final _appLinks = AppLinks();
  VoidCallback? _onAuthComplete;
  Function(String)? _onAuthError;

  void initializeDeepLinking() {
    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    print("Deep link received: $uri");
    if (uri.scheme == 'ewatts' &&
        uri.host == 'oauth' &&
        uri.path == '/callback') {
      final success = uri.queryParameters['success'];
      final error = uri.queryParameters['error'];
      final accessToken = uri.queryParameters['access_token'];
      final refreshToken = uri.queryParameters['refresh_token'];
      final expiresIn = uri.queryParameters['expires_in'];

      if (success == 'true' && accessToken != null && refreshToken != null) {
        // Save tokens to secure storage
        _saveTokens(accessToken, refreshToken, expiresIn);
        _onAuthComplete?.call();
      } else {
        _onAuthError?.call(error ?? 'Unknown error');
      }
    }
  }

  Future<void> _saveTokens(
    String accessToken,
    String refreshToken,
    String? expiresIn,
  ) async {
    // Implement your token storage logic here
    // For example, using flutter_secure_storage:
    // await storage.write(key: 'access_token', value: accessToken);
    // await storage.write(key: 'refresh_token', value: refreshToken);
    print('Tokens saved: $accessToken, $refreshToken');
  }

  void startOAuthFlow(
    String provider,
    BuildContext context, {
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    _onAuthComplete = onSuccess;
    _onAuthError = onError;

    try {
      final oauthService = OAuthService();
      final authUrl = await oauthService.getOAuthUrl(provider);

      if (!context.mounted) return;

      // Navigate to OAuth WebView
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OAuthWebView(
            authUrl: authUrl,
            onCancel: () {
              Navigator.of(context).pop();
              onError('User cancelled');
            },
          ),
        ),
      );
    } catch (e) {
      onError('Failed to start OAuth: $e');
    }
  }
}
