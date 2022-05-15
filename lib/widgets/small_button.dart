import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.longText,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  final String longText;
  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          longText,
          style: TextStyle(color: Colors.grey.shade500),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
