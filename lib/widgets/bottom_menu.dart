import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final VoidCallback onCash;
  final VoidCallback onHistory;
  final VoidCallback onInfo;

  const BottomMenu({
    required this.onCash,
    required this.onHistory,
    required this.onInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _item(Icons.attach_money, "Касса", onCash),
        _item(Icons.history, "История", onHistory),
        _item(Icons.info_outline, "Инфо", onInfo),
      ],
    );
  }

  Widget _item(IconData icon, String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade900,
        minimumSize: const Size(110, 45),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey),
          Text(text,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
