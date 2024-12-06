import 'package:flutter/material.dart';

class BigActionButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double margins;
  final double? height;
  final double? width;
  final double? iconSize;
  final IconData? icon;
  final Color? color;
  final Color? iconBgColor;
  final Color? iconColor;

  const BigActionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.margins = 14,
    this.height,
    this.width,
    this.iconSize = 24,
    this.color = Colors.white,
    this.iconBgColor = Colors.green,
    required this.icon,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(margins),
        height: height ?? MediaQuery.of(context).size.height * .1,
        width: width ?? MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              height: height ?? MediaQuery.of(context).size.height * .1 / 2,
              width: width ?? MediaQuery.of(context).size.width * .4 / 2.6,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: iconSize),
            ),
            SizedBox(
              width: width ?? MediaQuery.of(context).size.width * .4 / 2,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
