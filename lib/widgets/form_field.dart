import 'package:flutter/material.dart';

class FormField extends StatefulWidget {
  const FormField({Key? key, required this.formType}) : super(key: key);
  final Enum formType;

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  TextEditingController fullName = TextEditingController();
  TextEditingController passportnum = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController dbo = TextEditingController();
  TextEditingController result = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your full name',
            ),
          ),
        ],
      ),
    );
  }
}
