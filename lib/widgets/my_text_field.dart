import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    this.hintText,
    required this.title,
    this.keyboardType,
    required this.icon,
  }) : super(key: key);
  final TextEditingController controller;
  final String? hintText;
  final String title;
  final TextInputType? keyboardType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hintText == 'Company\'s service number' ? true : false,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        labelText: title,
        labelStyle: TextStyle(
          color: Colors.lightBlueAccent.withOpacity(0.8),
          fontSize: 14,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.lightBlueAccent.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
