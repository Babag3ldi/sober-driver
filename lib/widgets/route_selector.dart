import 'package:flutter/material.dart';

class RouteSelector extends StatelessWidget {
  final String? from;
  final String? to;
  final List<String> cities;
  final Function(String?) onFromChanged;
  final Function(String?) onToChanged;

  const RouteSelector({
    required this.from,
    required this.to,
    required this.cities,
    required this.onFromChanged,
    required this.onToChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: from,
          decoration: _decoration("Откуда"),
          items: cities.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: onFromChanged,
          validator: (value) {
            if (value == null) {
              return "Hökman saýlamaly";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: to,
          decoration: _decoration("Куда"),
          items: cities.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: onToChanged,
        ),
      ],
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );
  }
}
