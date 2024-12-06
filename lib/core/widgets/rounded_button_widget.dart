import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final bool enabled;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor,
    this.enabled = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle().copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor ?? Theme.of(context).primaryColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide.none,
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 14),
        ),
        elevation: MaterialStateProperty.all<double>(5),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        buttonText,
        style: TextStyle(color: textColor ?? Colors.white)  ,
      ),
    );
  }
}
