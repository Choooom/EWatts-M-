import 'dart:async';

import 'package:flutter/material.dart';

class CustomSnackBar {
  static DateTime? _lastSnackBarTime;
  static bool _isSnackBarActive = false;
  static String? _lastMessage;
  static Timer? _debounceTimer;

  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.redAccent,
    IconData icon = Icons.error_outline,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Duration debounceDuration = const Duration(milliseconds: 300),
    bool allowSameMessage = false,
  }) {
    final now = DateTime.now();
    final messenger = ScaffoldMessenger.of(context);

    // Cancel any existing debounce timer
    _debounceTimer?.cancel();

    // Check if we should ignore this call
    if (_shouldIgnoreCall(message, now, allowSameMessage)) {
      return;
    }

    // Set up debounced execution
    _debounceTimer = Timer(debounceDuration, () {
      _executeSnackBar(
        context,
        message: message,
        backgroundColor: backgroundColor,
        icon: icon,
        duration: duration,
        behavior: behavior,
        messenger: messenger,
        now: now,
      );
    });
  }

  static bool _shouldIgnoreCall(
    String message,
    DateTime now,
    bool allowSameMessage,
  ) {
    // If a SnackBar is currently active, ignore rapid calls
    if (_isSnackBarActive) {
      return true;
    }

    // If the same message was shown recently and allowSameMessage is false
    if (!allowSameMessage &&
        _lastMessage == message &&
        _lastSnackBarTime != null &&
        now.difference(_lastSnackBarTime!) < const Duration(seconds: 2)) {
      return true;
    }

    // If any SnackBar was shown very recently (within 500ms)
    if (_lastSnackBarTime != null &&
        now.difference(_lastSnackBarTime!) <
            const Duration(milliseconds: 500)) {
      return true;
    }

    return false;
  }

  static void _executeSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
    required SnackBarBehavior behavior,
    required ScaffoldMessengerState messenger,
    required DateTime now,
  }) {
    // Clear any existing SnackBar
    messenger.clearSnackBars();

    _isSnackBarActive = true;
    _lastMessage = message;
    _lastSnackBarTime = now;

    messenger
        .showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: backgroundColor,
            behavior: behavior,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: duration,
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.yellow,
              onPressed: () {
                messenger.hideCurrentSnackBar();
                _isSnackBarActive = false;
              },
            ),
            onVisible: () {
              // SnackBar is now visible
              _isSnackBarActive = true;
            },
          ),
          snackBarAnimationStyle: AnimationStyle(
            curve: Curves.easeInOutBack,
            reverseCurve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 600),
            reverseDuration: const Duration(milliseconds: 400),
          ),
        )
        .closed
        .then((_) {
          // SnackBar has been dismissed (either by user or timeout)
          _isSnackBarActive = false;
        });
  }

  // Force show a SnackBar even if one is active (emergency use)
  static void forceShow(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.redAccent,
    IconData icon = Icons.error_outline,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    _debounceTimer?.cancel();
    _isSnackBarActive = false; // Reset the flag

    show(
      context,
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
      behavior: behavior,
      debounceDuration: Duration.zero, // No debounce for force show
    );
  }

  // Clear all timers and reset state (useful for testing or cleanup)
  static void reset() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    _isSnackBarActive = false;
    _lastSnackBarTime = null;
    _lastMessage = null;
  }

  // Utility methods for common SnackBar types
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_outline,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.redAccent,
      icon: Icons.error_outline,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning_outlined,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info_outline,
      duration: duration,
    );
  }
}
