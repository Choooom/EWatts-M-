import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the state of a single device's electrical readings.
@immutable
class DeviceReadingState {
  final String voltage;
  final String current;
  final String power;
  final String energy;
  final String ssrState;
  final String connectionStatus;
  final bool isConnected;

  const DeviceReadingState({
    this.voltage = "---",
    this.current = "---",
    this.power = "---",
    this.energy = "---",
    this.ssrState = "---",
    this.connectionStatus = "Disconnected",
    this.isConnected = false,
  });

  /// Factory for the initial state.
  factory DeviceReadingState.initial() => const DeviceReadingState();

  /// Creates a copy of the state with new values.
  DeviceReadingState copyWith({
    String? voltage,
    String? current,
    String? power,
    String? energy,
    String? ssrState,
    String? connectionStatus,
    bool? isConnected,
  }) {
    return DeviceReadingState(
      voltage: voltage ?? this.voltage,
      current: current ?? this.current,
      power: power ?? this.power,
      energy: energy ?? this.energy,
      ssrState: ssrState ?? this.ssrState,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}

/// StateNotifier that holds and manages the DeviceReadingState.
class DeviceReadingNotifier extends StateNotifier<DeviceReadingState> {
  DeviceReadingNotifier() : super(DeviceReadingState.initial());

  /// Updates the state from a new data map (from WebSocket).
  void updateReadings(Map<String, dynamic> data) {
    if (!mounted) return;
    state = state.copyWith(
      voltage: data['voltage']?.toStringAsFixed(2) ?? state.voltage,
      current: data['current']?.toStringAsFixed(4) ?? state.current,
      power: data['power']?.toStringAsFixed(2) ?? state.power,
      energy: data['energy']?.toStringAsFixed(5) ?? state.energy,
      ssrState: data['ssrState'] ?? state.ssrState,
    );
  }

  /// Updates the WebSocket connection status.
  void setConnectionStatus(String status, bool connected) {
    if (!mounted) return;
    state = state.copyWith(connectionStatus: status, isConnected: connected);
  }

  /// Resets the state to initial values.
  void reset() {
    if (!mounted) return;
    state = DeviceReadingState.initial();
  }
}

/// The Riverpod provider for the DeviceReadingNotifier.
final deviceReadingProvider =
    StateNotifierProvider<DeviceReadingNotifier, DeviceReadingState>(
      (ref) => DeviceReadingNotifier(),
    );
