import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.buttonText, this.onPressed}) : super(key: key);

  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: Colours.gradient2,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            letterSpacing: 1,
            fontSize: 16,
            fontFamily: 'Foo-Bold',
          ),
        ),
      ),
    );
  }
}
