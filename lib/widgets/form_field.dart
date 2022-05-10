import 'package:covid_result_checker/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyFormField extends StatefulWidget {
  const MyFormField({Key? key, required this.formType}) : super(key: key);
  final Enum formType;

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  TextEditingController fullName = TextEditingController();
  TextEditingController passportnum = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController dbo = TextEditingController();
  TextEditingController result = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Field'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: fullName,
            decoration: InputDecoration(
              hintText: 'Enter your full name',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passportnum,
            decoration: InputDecoration(
              hintText: 'Enter your passport number',
            ),
          ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: sex,
              decoration: InputDecoration(
                hintText: 'Enter your sex',
              ),
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: dbo,
              decoration: InputDecoration(
                hintText: 'Enter your DBO',
              ),
            ),
          SizedBox(height: 30),
          EditingButton(
            onTap: () {
              if (widget.formType == FormType.AddUser) {}
              if (widget.formType == FormType.UpdateUser) {}
              if (widget.formType == FormType.DeleteUser) {}
            },
            color: Colors.green,
            text: widget.formType == FormType.AddUser
                ? 'Save user'
                : widget.formType == FormType.UpdateUser
                    ? 'Update User'
                    : 'Delete user',
          ),
        ],
      ),
    );
  }
}
