import 'package:flutter/material.dart';

class PriceDisplay extends StatelessWidget {
  final int price;

  const PriceDisplay({required this.price, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("СУММА",
            style: TextStyle(fontSize: 25, color: Colors.grey)),
        const SizedBox(width: 25),
        Text(
          "$price",
          style: const TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 20),
        const Text("TMT", style: TextStyle(fontSize: 25, color: Colors.grey)),
      ],
    );
  }
}
