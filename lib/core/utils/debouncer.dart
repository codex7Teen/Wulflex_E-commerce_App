import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  final int milliSeconds;
  Timer? _timer;

  Debouncer({required this.milliSeconds});

  void run(VoidCallback action) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSeconds), action);
  }

  /// Runs an action, but only if no other action has been called within the debounce period
  void debounce(VoidCallback action) {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer(Duration(milliseconds: milliSeconds), action);
    }
  }

  /// Cancels the current timer if it's active
  void cancel() {
    _timer?.cancel();
  }

  /// Disposes of the timer to prevent memory leaks
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

/// Extension method to add debounce functionality to any function
extension DebouncerExtension on VoidCallback {
  /// Creates a debounced version of the callback
  VoidCallback debounce({int milliseconds = 500}) {
    final debouncer = Debouncer(milliSeconds: milliseconds);
    return () {
      debouncer.run(this);
    };
  }
}
