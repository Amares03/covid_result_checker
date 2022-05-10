// ignore_for_file: prefer_const_constructors

import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/services/createUser.dart';
import 'package:covid_result_checker/services/userModel.dart';
import 'package:flutter/material.dart';

//  https://covid-result-tester.herokuapp.com/

CreateUser createUser = CreateUser();

class MyFormField extends StatefulWidget {
  const MyFormField({Key? key, required this.formType}) : super(key: key);
  final Enum formType;

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController passportNum = TextEditingController();
  TextEditingController dbo = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController result = TextEditingController();
  TextEditingController resultDate = TextEditingController();
  TextEditingController reviewedBy = TextEditingController();
  TextEditingController sex = TextEditingController();

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
            validator: (value) {
              if (value!.isEmpty) {
                return "cannot be empty";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passportNum,
            decoration: InputDecoration(
              hintText: 'Enter your passport number',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "cannot be empty";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: dbo,
              decoration: InputDecoration(
                hintText: 'Enter your DBO',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: nationality,
              decoration: InputDecoration(
                hintText: 'Enter your nationality',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: phone,
              decoration: InputDecoration(
                hintText: 'Enter your Phone number',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: result,
              decoration: InputDecoration(
                hintText: 'Enter your result',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: resultDate,
              decoration: InputDecoration(
                hintText: 'Enter your result date',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: reviewedBy,
              decoration: InputDecoration(
                hintText: 'Enter your Dr name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 20),
          if (widget.formType != FormType.DeleteUser)
            TextFormField(
              controller: sex,
              decoration: InputDecoration(
                hintText: 'Enter your sex',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
          SizedBox(height: 30),
          EditingButton(
            onTap: () async {
              if (widget.formType == FormType.AddUser) {
                final UserModel user = await createUser.createUser(
                    fullName.text,
                    passportNum.text,
                    dbo.text,
                    nationality.text,
                    phone.text,
                    result.text,
                    resultDate.text,
                    reviewedBy.text,
                    sex.text);
              }
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
