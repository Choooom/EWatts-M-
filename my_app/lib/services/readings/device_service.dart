import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Import your existing providers and constants
import 'package:my_app/constants/consts.dart'; // For base_url
import 'package:my_app/models/auth/jwt_response.dart';
import 'package:my_app/models/auth/user_dto.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/providers/readings/device_reading_provider.dart';
import 'package:my_app/services/auth/token_storage_service.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

/// Service class to manage device communication (WebSocket and HTTP).
class DeviceService {
  final Ref _ref;
  StompClient? _stompClient;

  // Get dependencies from Riverpod
  TokenStorageService get _tokenStorage => _ref.read(tokenStorageProvider);
  DeviceReadingNotifier get _readingNotifier =>
      _ref.read(deviceReadingProvider.notifier);

  DeviceService(this._ref);

  /// Retrieves the current access token.
  Future<String?> _getAccessToken() async {
    final JwtResponse? jwt = await _tokenStorage.getStoredJwtResponse();
    return jwt?.accessToken;
  }

  /// Retrieves the current User ID.
  Future<int?> _getUserId() async {
    final JwtResponse? jwt = await _tokenStorage.getStoredJwtResponse();
    dynamic userId = jwt?.user?.id;
    if (userId is int) {
      return userId;
    }
    if (userId is String) {
      return int.tryParse(userId);
    }
    return null;
  }

  /// Connects to the STOMP WebSocket server.
  Future<void> connectWebSocket() async {
    try {
      _readingNotifier.setConnectionStatus("Connecting...", false);
    } catch (e) {
      print("DeviceService: Error setting connection status: $e");
      return;
    }

    final String? token = await _getAccessToken();
    final int? userId = await _getUserId();

    if (token == null || userId == null) {
      print("DeviceService: Cannot connect, no auth token or user ID found.");
      try {
        _readingNotifier.setConnectionStatus("Auth Error", false);
      } catch (e) {
        print("DeviceService: Widget disposed, cannot update status");
      }
      return;
    }

    // Use HTTPS URL with SockJS - the library will handle the protocol upgrade
    // SockJS uses HTTP/HTTPS for initial handshake, then upgrades to WebSocket
    final String stompUrl = '$base_url/api/iot/ws';

    print("DeviceService: Connecting to STOMP at $stompUrl with SockJS");

    _stompClient = StompClient(
      config: StompConfig(
        url: stompUrl,
        // IMPORTANT: Enable SockJS
        useSockJS: true,
        onConnect: (StompFrame frame) {
          _readingNotifier.setConnectionStatus("Connected", true);
          print("DeviceService: STOMP Connected!");

          // Subscribe to the user-specific topic
          final String destination = "/topic/user/$userId/readings";
          print("DeviceService: Subscribing to $destination");

          _stompClient!.subscribe(
            destination: destination,
            callback: (StompFrame frame) {
              // Data received
              if (frame.body != null) {
                try {
                  final Map<String, dynamic> wsMessage = json.decode(
                    frame.body!,
                  );

                  if (wsMessage['type'] == 'READING' &&
                      wsMessage['payload'] != null) {
                    final Map<String, dynamic> data = wsMessage['payload'];
                    _readingNotifier.updateReadings(data);
                  }

                  if (wsMessage['type'] == 'SSR_CONTROL' &&
                      wsMessage['payload'] != null) {
                    final Map<String, dynamic> data = wsMessage['payload'];
                    _readingNotifier.updateReadings({
                      'ssrState': data['ssrEnabled'] == true ? 'ON' : 'OFF',
                    });
                  }
                } catch (e) {
                  print('DeviceService: Failed to parse STOMP message: $e');
                }
              }
            },
          );
        },
        beforeConnect: () async {
          print("DeviceService: Before connect - initiating handshake");
        },
        onWebSocketError: (dynamic error) {
          _readingNotifier.setConnectionStatus("Error", false);
          print("DeviceService: STOMP WebSocket Error: $error");
        },
        onStompError: (StompFrame frame) {
          _readingNotifier.setConnectionStatus("STOMP Error", false);
          print("DeviceService: STOMP Protocol Error: ${frame.body}");
        },
        onDisconnect: (StompFrame frame) {
          _readingNotifier.setConnectionStatus("Disconnected", false);
          print("DeviceService: STOMP Disconnected.");
        },
        onWebSocketDone: () {
          print("DeviceService: WebSocket connection closed");
        },
        // Pass auth token in headers
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
        // Increase connection timeout for SockJS
        connectionTimeout: Duration(seconds: 10),
        // Add heartbeat to keep connection alive
        heartbeatIncoming: Duration(seconds: 30),
        heartbeatOutgoing: Duration(seconds: 30),
      ),
    );

    _stompClient!.activate();
  }

  /// Disconnects from the WebSocket.
  void disconnectWebSocket() {
    _stompClient?.deactivate();
    _stompClient = null;
    _readingNotifier.reset();
    print("DeviceService: STOMP manually disconnected.");
  }

  /// Sends a control command (ON/OFF) via HTTP POST.
  Future<bool> sendControlCommand(String deviceId, String command) async {
    print("DeviceService: Attempting to send $command to device $deviceId");

    final String? token = await _getAccessToken();
    if (token == null) {
      print("DeviceService: Cannot send command, no auth token.");
      return false;
    }

    final url = Uri.parse('$base_url/api/iot/devices/$deviceId/ssr-control');
    print("DeviceService: URL: $url");

    final body = json.encode({'enabled': command == "ON" ? true : false});
    print("DeviceService: Request body: $body");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print('DeviceService: Response status: ${response.statusCode}');
      print('DeviceService: Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('DeviceService: Control command "$command" sent successfully.');
        return true;
      } else {
        print('DeviceService: Failed to send command: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('DeviceService: Error sending HTTP command: $e');
      return false;
    }
  }
}

/// The Riverpod provider for the DeviceService.
final deviceServiceProvider = Provider<DeviceService>(
  (ref) => DeviceService(ref),
);
