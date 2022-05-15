import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/logo.png',
          height: 120,
          width: 150,
        ),
        const Expanded(
          child: BigText(text: 'Covid Result Checker'),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
