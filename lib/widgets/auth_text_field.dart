import 'package:covid_result_checker/utils/colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && isHiddenPassword ? true : false,
      autocorrect: widget.isPassword && isHiddenPassword ? true : false,
      style: TextStyle(color: Colours.bigTextBlackColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colours.mainColor.withOpacity(0.3),
          ),
        ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(() => isHiddenPassword = !isHiddenPassword),
                child: Icon(
                  isHiddenPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: isHiddenPassword ? Colors.grey : Colours.mainColor,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
