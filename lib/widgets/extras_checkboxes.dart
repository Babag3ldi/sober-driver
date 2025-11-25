import 'package:flutter/material.dart';

class ExtrasCheckboxes extends StatelessWidget {
  final bool isSpes;
  final bool isPogoda;
  final Function(bool) onSpesChanged;
  final Function(bool) onPogodaChanged;

  const ExtrasCheckboxes({
    required this.isSpes,
    required this.isPogoda,
    required this.onSpesChanged,
    required this.onPogodaChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35,
          child: CheckboxListTile(
            value: isSpes,
            onChanged: (v) => onSpesChanged(v!),
            title: const Text(
              "Спец. вызов",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          child: CheckboxListTile(
            value: isPogoda,
            onChanged: (v) => onPogodaChanged(v!),
            title: const Text(
              "Погодные условия",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
