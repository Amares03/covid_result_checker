import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:flutter/material.dart';

class PatientInfoTextField extends StatelessWidget {
  const PatientInfoTextField({
    Key? key,
    this.text,
    this.editingController,
    this.hintText,
    this.suffixIcon,
  }) : super(key: key);
  final String? text;
  final TextEditingController? editingController;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (text != null)
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SmallText(text: text ?? ''),
          ),
        if (text != null) const SizedBox(height: 5),
        TextFormField(
          controller: editingController,
          style: TextStyle(color: Colors.grey.shade700),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            isDense: true,
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontSize: 15,
              letterSpacing: 1,
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
        ),
      ],
    );
  }
}
