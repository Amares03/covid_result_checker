import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: color ?? Colors.grey.shade700,
      ),
    );
  }
}
