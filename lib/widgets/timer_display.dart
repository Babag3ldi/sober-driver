import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final Duration duration;

  const TimerDisplay({required this.duration, super.key});

  @override
  Widget build(BuildContext context) {
    String two(int n) => n.toString().padLeft(2, '0');

    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60);
    final s = duration.inSeconds.remainder(60);

    final formatted =
        h > 0 ? "$h:${two(m)}:${two(s)}" : "${two(duration.inMinutes)}:${two(s)}";

    return Text(
      formatted,
      style: const TextStyle(
        fontSize: 65,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: "Digital",
      ),
    );
  }
}
