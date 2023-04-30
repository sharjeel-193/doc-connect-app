import 'package:flutter/material.dart';

class TimeSlotButton extends StatelessWidget {
  final String time;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback? onSelected;

  TimeSlotButton({
    required this.time,
    required this.isBooked,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.white;
    Color borderColor = Colors.black;
    Color textColor = Colors.black;
    if (isSelected) {
      buttonColor = Colors.blue;
      borderColor = Colors.blue;
      textColor = Colors.white;
    } else if (isBooked) {
      buttonColor = Theme.of(context).colorScheme.onPrimary;
      borderColor = Theme.of(context).colorScheme.onPrimary;
      textColor = Colors.white;
    } else {
      borderColor = Colors.blue;
    }

    return GestureDetector(
      onTap: isBooked ? null : onSelected,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Text(
          time,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
