import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final Color backgroundColor;
  final Color textColor;
  final String displayText;

  const StatusBadge({
    Key? key,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
    required this.displayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
