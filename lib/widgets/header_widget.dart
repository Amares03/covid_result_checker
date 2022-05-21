import 'package:covid_result_checker/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 120,
        ),
        const SizedBox(width: 20),
        Text(
          'Covid Result\nChecker',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Foo-Black',
            fontSize: 24,
            letterSpacing: 1.2,
            color: Colours.bigTextBlackColor,
          ),
        ),
      ],
    );
  }
}
