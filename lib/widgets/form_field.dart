import 'package:cool_alert/cool_alert.dart';
import 'package:covid_result_checker/helper/database_manager.dart';
import 'package:covid_result_checker/helper/user_model.dart';
import 'package:covid_result_checker/services/enums.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/widgets/big_button.dart';
import 'package:covid_result_checker/widgets/patient_info_text_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

import '../components/display_snackbar.dart';

class PatientFormField extends StatefulWidget {
  const PatientFormField({Key? key, this.formType}) : super(key: key);
  final Enum? formType;
  @override
  State<PatientFormField> createState() => _PatientFormFieldState();
}

class _PatientFormFieldState extends State<PatientFormField> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController idNumber;
  late TextEditingController birthDate;
  late TextEditingController nationality;
  late TextEditingController gender;
  late TextEditingController result;
  late TextEditingController resultDate;
  late TextEditingController docName;

  DateTime today = DateTime.now();

  List<String> genderList = ['Male', 'Female'];
  String? selectedGender;

  List<String> resultList = ['Negative', 'Positive'];
  String? selectedResult;

  String? qrData;

  bool isLoading = false;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    idNumber = TextEditingController();
    birthDate = TextEditingController();
    nationality = TextEditingController();
    gender = TextEditingController();
    result = TextEditingController();
    resultDate = TextEditingController();

    birthDate.text = '${today.day} / ${today.month} / ${today.year}';
    resultDate.text = '${today.day} / ${today.month} / ${today.year}';
    nationality.text = 'Ethiopia';

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
    result.dispose();
    resultDate.dispose();
    docName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.mainColor,
        leading: const BackButton(),
        title: const Text(
          'Patient Information',
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // full name field
                Row(
                  children: [
                    Expanded(
                      child: PatientInfoTextField(
                        editingController: firstName,
                        text: 'first name',
                        hintText: 'enter first name',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PatientInfoTextField(
                        editingController: lastName,
                        text: 'last name',
                        hintText: 'enter last name',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // id Field
                PatientInfoTextField(
                  editingController: idNumber,
                  text: 'identification code',
                  hintText: 'passport or kebele id',
                  suffixIcon: const Icon(Icons.warning_amber_rounded),
                ),
                const SizedBox(height: 15),
                // birthday and gender field
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: PatientInfoTextField(
                        editingController: birthDate,
                        text: 'Date of birth',
                        suffixIcon: IconButton(
                          onPressed: () => changeDate(field: 'birth'),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: PatientInfoTextField(
                        editingController: gender,
                        text: 'Gender',
                        suffixIcon: dropDownMenu(
                          hint: 'Gender',
                          menuList: genderList,
                          selectedItem: selectedGender,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // natinality field
                PatientInfoTextField(
                  editingController: nationality,
                  text: 'Nationality',
                ),
                const SizedBox(height: 15),
                // result field
                PatientInfoTextField(
                  editingController: result,
                  text: 'Result',
                  suffixIcon: dropDownMenu(
                    hint: 'Result',
                    menuList: resultList,
                    selectedItem: selectedResult,
                  ),
                ),
                const SizedBox(height: 15),
                PatientInfoTextField(
                  editingController: resultDate,
                  text: 'Result taken date',
                  suffixIcon: IconButton(
                    onPressed: () => changeDate(field: 'result'),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      qrData == null
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.qr_code),
                                  SizedBox(height: 5),
                                  Text('waiting qr data'),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 150,
                              width: 150,
                              child: PrettyQr(
                                size: 150,
                                data: qrData!,
                                roundEdges: true,
                                image: const AssetImage('assets/logo.png'),
                                elementColor: Colours.mainColor,
                                errorCorrectLevel: QrErrorCorrectLevel.M,
                              ),
                            ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        qrData = 'www.google.com';
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text('Generate QR'),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.refresh),
                                  ),
                                ),
                              ],
                            ),
                            BigButton(
                              onTap: () {
                                if (firstName.text.isEmpty ||
                                    lastName.text.isEmpty) {
                                  displaySnackBar(
                                    context,
                                    messageDescription:
                                        'Make sure that the name field is not empty!',
                                  );
                                } else if (idNumber.text.isEmpty) {
                                  displaySnackBar(
                                    context,
                                    messageDescription:
                                        'Make sure that the Id Verification field is not empty!',
                                  );
                                } else if (idNumber.text.length < 4) {
                                  displaySnackBar(
                                    context,
                                    messageDescription:
                                        'Make sure you entered 4 or more characters in id field!',
                                  );
                                } else if (selectedGender == null) {
                                  displaySnackBar(
                                    context,
                                    messageDescription:
                                        'Please choose patient\'s gender!',
                                  );
                                } else if (selectedResult == null) {
                                  displaySnackBar(
                                    context,
                                    messageDescription:
                                        'Please fill patient\'s result!',
                                  );
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  insertData();
                                }
                              },
                              text: 'Save patient data.',
                              fontSize: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.black.withOpacity(0.2),
              child: Center(
                child: SpinKitThreeInOut(color: Colours.mainColor),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> insertData() async {
    final patientData = PatientModel(
      fullName: '${firstName.text} ${lastName.text}',
      passportNumber: idNumber.text,
      dateOfBirth: birthDate.text,
      gender: selectedGender!,
      nationality: nationality.text,
      result: selectedResult!,
      resultTakenDate: resultDate.text,
    );
    OperationStatus newResult = await DatabaseManager.addNewPatient(
      patient: patientData,
    );

    if (newResult == OperationStatus.createSuccess) {
      Navigator.of(context).pop();
      displaySnackBar(
        context,
        messageDescription: 'New patient data created!',
        cardBgColor: Colors.green,
        iconName: 'success',
        messageTitle: 'Success',
      );
    } else {
      displaySnackBar(
        context,
        messageDescription: 'Something terrible happened!',
        messageTitle: 'Oh snap!',
      );
    }

    setState(() => isLoading = false);

    resetTextField();
  }

  void resetTextField() {
    firstName.text = '';
    lastName.text = '';
    idNumber.text = '';
    birthDate.text = '${today.day} / ${today.month} / ${today.year}';
    selectedGender = null;
    nationality.text = 'Ethiopia';
    selectedResult = null;
    resultDate.text = '${today.day} / ${today.month} / ${today.year}';
  }

  DropdownButtonHideUnderline dropDownMenu({
    required String hint,
    required List<String> menuList,
    String? selectedItem,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: selectedItem,
        hint: Text(
          hint,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        items: menuList.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          );
        }).toList(),
        style: TextStyle(
          color: Colors.grey.shade700,
          letterSpacing: 1,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        onChanged: (value) => setState(() {
          if (hint.toLowerCase() == 'gender') {
            selectedGender = value.toString();
          }
          if (hint.toLowerCase() == 'result') {
            selectedResult = value.toString();
          }
        }),
        buttonHeight: 42,
        buttonWidth: double.maxFinite,
        buttonDecoration: BoxDecoration(
          color: hint.toLowerCase() == 'result'
              ? Colours.mainColor.withOpacity(0.08)
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        buttonPadding: const EdgeInsets.only(
          left: 20,
          right: 10,
        ),
        itemHeight: 40,
      ),
    );
  }

  changeDate({required String field}) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != today) {
      setState(() {
        if (field == 'birth') {
          birthDate.text =
              "${selected.day} / ${selected.month} / ${selected.year}";
        }
        if (field == 'result') {
          resultDate.text =
              "${selected.day} / ${selected.month} / ${selected.year}";
        }
      });
    }
  }
}
