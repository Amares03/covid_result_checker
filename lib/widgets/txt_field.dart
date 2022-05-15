import 'package:flutter/material.dart';

class TxTField extends StatelessWidget {
  const TxTField({
    Key? key,
    required this.hintText,
    this.isPassword,
    required this.editingController,
  }) : super(key: key);
  final String hintText;
  final bool? isPassword;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ?? false,
      autocorrect: isPassword ?? false,
      style: TextStyle(
        color: Colors.grey.shade500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.6),
          fontSize: 15,
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
