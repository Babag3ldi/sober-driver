import 'package:flutter/material.dart';

class StartFinishButtons extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onFinish;

  const StartFinishButtons({
    required this.isRunning,
    required this.onStart,
    required this.onFinish,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isRunning ? null : onStart,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            minimumSize: const Size(150, 60),
          ),
          child: const Text("Start", style: TextStyle(fontSize: 26)),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: isRunning ? onFinish : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(150, 60),
          ),
          child: const Text("Finish", style: TextStyle(fontSize: 26)),
        ),
      ],
    );
  }
}
