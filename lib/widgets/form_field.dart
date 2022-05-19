// ignore_for_file: prefer_const_constructors

import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/services/createUser.dart';
import 'package:covid_result_checker/services/apiFunctions.dart';
import 'package:covid_result_checker/services/userModel.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/widgets/txt_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

CreateUser createUser = CreateUser();
ApiFunction apiFunction = ApiFunction();

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
  // TextEditingController nationality = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController result = TextEditingController();
  TextEditingController resultDate = TextEditingController();
  TextEditingController reviewedBy = TextEditingController();
  TextEditingController sex = TextEditingController();

  final List<String> genderMenuList = ['Male', 'Female'];
  String? selectedGenderType;

  String nationalitString = '';

  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController idNumber;
  late TextEditingController birthDate;
  late TextEditingController nationality;
  late TextEditingController gender;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    idNumber = TextEditingController();
    birthDate = TextEditingController();
    nationality = TextEditingController();
    gender = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    idNumber.dispose();
    birthDate.dispose();
    nationality.dispose();
    gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nationality.text = 'Ethiopia';
    gender.text = 'male';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.mainColor,
        title: Text('Patient Form Field'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              // full name textfield
              Row(
                children: [
                  Expanded(
                    child: TxTField(
                      hintText: 'first name',
                      editingController: firstName,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TxTField(
                      hintText: 'last name',
                      editingController: lastName,
                      mandatory: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              TxTField(
                hintText: 'passport or kebele id',
                editingController: idNumber,
                mandatory: true,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TxTField(
                      hintText: 'Date of birth',
                      editingController: birthDate,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TxTField(
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Gender',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          items: genderMenuList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            );
                          }).toList(),
                          value: selectedGenderType,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            letterSpacing: 1,
                          ),
                          onChanged: (value) => setState(
                            () => selectedGenderType = value as String,
                          ),
                          buttonHeight: 42,
                          buttonWidth: double.maxFinite,
                          buttonPadding: EdgeInsets.only(left: 20, right: 10),
                          itemHeight: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),
              TxTField(editingController: nationality),
              SizedBox(height: 15),
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
              Row(
                children: [
                  Expanded(
                    child: EditingButton(
                      onTap: () async {
                        if (widget.formType == FormType.AddUser) {
                          final UserModel user = await createUser.createUser(
                              '${firstName.text}  ${lastName.text}',
                              idNumber.text,
                              dbo.text,
                              nationality.text,
                              phone.text,
                              result.text,
                              resultDate.text,
                              reviewedBy.text,
                              sex.text);
                          formKey.currentState!.reset();
                        }
                        if (widget.formType == FormType.UpdateUser) {
                          final UserModel userUpdate =
                              await apiFunction.updateUser(
                                  fullName.text,
                                  passportNum.text,
                                  dbo.text,
                                  nationality.text,
                                  phone.text,
                                  result.text,
                                  resultDate.text,
                                  reviewedBy.text,
                                  sex.text);
                          formKey.currentState!.reset();
                        }
                        if (widget.formType == FormType.DeleteUser) {
                          final UserModel userDelete =
                              await apiFunction.deleteUser(passportNum.text);
                        }
                      },
                      color: Colors.green,
                      text: widget.formType == FormType.AddUser
                          ? 'Save user'
                          : widget.formType == FormType.UpdateUser
                              ? 'Update User'
                              : 'Delete user',
                    ),
                  ),
                  if (widget.formType == FormType.UpdateUser)
                    Expanded(
                      child: EditingButton(
                          onTap: () async {
                            final UserModel userFind =
                                await apiFunction.findUser(passportNum.text);
                            dynamic userInfo = apiFunction.getUserInfo();
                            fullName.text = userInfo['fullname'];
                            passportNum.text = userInfo['passportNum'];
                            dbo.text = userInfo['dbo'];
                            nationality.text = userInfo['nationality'];
                            phone.text = userInfo['phone'];
                            result.text = userInfo['result'];
                            resultDate.text = userInfo['resultDate'];
                            reviewedBy.text = userInfo['reviewedBy'];
                            sex.text = userInfo['sex'];
                          },
                          color: Colors.green,
                          text: 'find'),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
