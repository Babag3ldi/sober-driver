import 'dart:async';

class TimerService {
  Duration current = Duration.zero;
  Timer? _timer;

  Function(Duration)? onTick;

  void start() {
    stop();

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      current += const Duration(seconds: 1);
      if (onTick != null) onTick!(current);
    });
  }

  void reset() {
    current = Duration.zero;
  }

  void stop() {
    _timer?.cancel();
  }

  bool get isRunning => _timer != null;
}
