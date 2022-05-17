import 'package:covid_result_checker/utils/colors.dart';
import 'package:flutter/material.dart';

class TxTField extends StatefulWidget {
  const TxTField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    required this.editingController,
    this.onTap,
  }) : super(key: key);
  final String hintText;
  final bool isPassword;
  final TextEditingController editingController;
  final Function()? onTap;

  @override
  State<TxTField> createState() => _TxTFieldState();
}

class _TxTFieldState extends State<TxTField> {
  bool isHiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.editingController,
      obscureText: widget.isPassword && isHiddenPassword ? true : false,
      autocorrect: widget.isPassword && isHiddenPassword ? true : false,
      style: TextStyle(
        color: Colors.grey.shade500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        isDense: true,
        hintText: widget.hintText,
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
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () =>
                    setState(() => isHiddenPassword = !isHiddenPassword),
                child: Icon(
                  isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                  color: isHiddenPassword ? Colors.grey : Colours.mainColor,
                ),
              )
            : const SizedBox(height: 0),
      ),
    );
  }
}
