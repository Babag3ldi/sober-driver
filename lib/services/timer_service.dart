import 'dart:async';

class TimerService {
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  final void Function(Duration) onTick;

  TimerService({required this.onTick});

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed += const Duration(seconds: 1);
      onTick(_elapsed);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _elapsed = Duration.zero;
  }

  void dispose() {
    _timer?.cancel();
  }
}
