import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<Brightness>((ref) {
  // Use the new multi-window-safe API
  return PlatformDispatcher
      .instance
      .views
      .first
      .platformDispatcher
      .platformBrightness;
});

class ThemeModeListener with WidgetsBindingObserver {
  final WidgetRef ref;

  ThemeModeListener(this.ref);

  @override
  void didChangePlatformBrightness() {
    final brightness =
        PlatformDispatcher.instance.platformBrightness; // Updated API
    ref.read(themeModeProvider.notifier).state = brightness;
  }
}
