// lib/state_management/realtime_readings_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/readings/realtime_reading.dart';

class RealtimeReadingNotifier extends StateNotifier<List<RealtimeReading>> {
  RealtimeReadingNotifier() : super([]);

  void addReading(RealtimeReading reading) {
    state = [...state, reading];
  }

  void clear() => state = [];
}

final realtimeReadingsProvider =
    StateNotifierProvider<RealtimeReadingNotifier, List<RealtimeReading>>(
      (ref) => RealtimeReadingNotifier(),
    );
