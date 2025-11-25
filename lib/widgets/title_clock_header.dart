import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class TitleAndClockHeader extends StatelessWidget {
  const TitleAndClockHeader({
    super.key,
    required this.title,
    required DateTime selectDate,
  }) : _selectDate = selectDate;

  final String title;
  final DateTime _selectDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Трезвый Шофёр - Mr $title",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          textScaleFactor: 1,
        ),
        const SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          DigitalClock(
            areaDecoration: const BoxDecoration(color: Colors.transparent),
            areaAligment: AlignmentDirectional.center,
            minuteDigitDecoration:
                const BoxDecoration(color: Colors.transparent),
                hourDigitDecoration:
                const BoxDecoration(color: Colors.transparent),
            hourMinuteDigitTextStyle:
                const TextStyle(fontSize: 20, color: Colors.grey),
            secondDigitTextStyle:
                const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            DateFormat('dd-MM-yyyy').format(_selectDate),
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ]),
        const SizedBox(height: 30),
      ],
    );
  }
}