// lib/state_management/websocket_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/services/readings/web_socket_service.dart';

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  final service = WebSocketService();
  return service;
});
