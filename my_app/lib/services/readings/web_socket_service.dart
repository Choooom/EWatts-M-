import 'dart:convert';
import 'package:my_app/models/readings/device_status.dart';
import 'package:my_app/models/readings/realtime_reading.dart';
import 'package:my_app/models/readings/ssr_status.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:my_app/constants/consts.dart';

class WebSocketService {
  StompClient? _stompClient;
  String? _jwtToken;
  int? _userId;

  // Callbacks for different message types
  Function(RealtimeReading)? onReadingReceived;
  Function(SSRStatus)? onSSRStatusChanged;
  Function(DeviceStatus)? onDeviceStatusChanged;

  void connect(String jwtToken, int userId) {
    _jwtToken = jwtToken;
    _userId = userId;
    final String url = base_url;
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://$url/ws',
        onConnect: _onConnect,
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
        onStompError: (StompFrame frame) => print('Stomp Error: ${frame.body}'),
        onDisconnect: (frame) => print('Disconnected'),
        beforeConnect: () async {
          print('Connecting to WebSocket...');
        },
      ),
    );

    _stompClient!.activate();
  }

  void _onConnect(StompFrame frame) {
    print('Connected to WebSocket');

    // Subscribe to real-time readings
    _stompClient!.subscribe(
      destination: '/topic/user/$_userId/readings',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final data = jsonDecode(frame.body!);
          if (data['type'] == 'READING') {
            final reading = RealtimeReading.fromJson(data['payload']);
            onReadingReceived?.call(reading);
          }
        }
      },
    );

    // Subscribe to SSR control updates
    _stompClient!.subscribe(
      destination: '/topic/user/$_userId/ssr-control',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final data = jsonDecode(frame.body!);
          if (data['type'] == 'SSR_CONTROL') {
            final status = SSRStatus.fromJson(data['payload']);
            onSSRStatusChanged?.call(status);
          }
        }
      },
    );

    // Subscribe to device status updates
    _stompClient!.subscribe(
      destination: '/topic/user/$_userId/device-status',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final data = jsonDecode(frame.body!);
          if (data['type'] == 'DEVICE_STATUS') {
            final status = DeviceStatus.fromJson(data['payload']);
            onDeviceStatusChanged?.call(status);
          }
        }
      },
    );
  }

  void disconnect() {
    _stompClient?.deactivate();
  }
}
