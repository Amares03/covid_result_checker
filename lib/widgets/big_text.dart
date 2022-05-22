import 'package:covid_result_checker/utils/colors.dart';
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
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize ?? 24,
        fontFamily: 'Foo-Bold',
        letterSpacing: 1.2,
        color: color ?? Colours.bigTextBlackColor,
      ),
    );
  }
}
