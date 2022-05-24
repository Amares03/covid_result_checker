import 'package:covid_result_checker/db/database_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../db/user_model.dart';
import '../widgets/display_snackbar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/patient_info_text_field.dart';

class UpdatePatientView extends StatefulWidget {
  static const String routeName = '/updatePatientView/';

  const UpdatePatientView({Key? key, this.patient}) : super(key: key);

  final PatientModel? patient;

  @override
  State<UpdatePatientView> createState() => _UpdatePatientViewState();
}

class _UpdatePatientViewState extends State<UpdatePatientView> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController idNumber;
  late TextEditingController birthDate;
  late TextEditingController nationality;
  late TextEditingController gender;
  late TextEditingController result;
  late TextEditingController resultDate;

  List<String> genderList = ['Male', 'Female'];
  String? selectedGender;

  List<String> resultList = ['Negative', 'Positive'];
  String? selectedResult;

  DateTime today = DateTime.now();

  String qrData = '';

  bool loading = false;

  late bool shouldRebuild;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as PatientModel;

    final fullNameList = args.fullName.split(' ');
    if (fullNameList.length == 1) {
      firstName = TextEditingController(text: args.fullName.split(' ')[0]);
      lastName = TextEditingController(text: '');
    } else {
      firstName = TextEditingController(text: args.fullName.split(' ')[0]);
      lastName = TextEditingController(text: args.fullName.split(' ')[1]);
    }

    idNumber = TextEditingController(text: args.passportNumber);
    birthDate = TextEditingController(text: args.dateOfBirth);
    nationality = TextEditingController(text: args.nationality);
    gender = TextEditingController(text: args.gender);
    selectedGender = args.gender;
    selectedResult = args.result;
    result = TextEditingController();
    resultDate = TextEditingController(text: args.resultTakenDate);

    idNumber.addListener(() => setState(() => qrData = ''));

    super.didChangeDependencies();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb774bd),
        title: const Text('Modify or remove record'),
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
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: PrettyQr(
                          size: 150,
                          data: 'https://covid-result-tester.herokuapp.com/test-result-using-qr-code/${idNumber.text}',
                          roundEdges: true,
                          image: const AssetImage('assets/logo.png'),
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 48,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: const Color(0xffb774bd),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                            onPressed: updatePatient,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 16, letterSpacing: 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.black.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  LoadingWidget(
                    color: Color(0xffb774bd),
                    title: 'Saving Data',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
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
          if (hint.toLowerCase() == 'gender') selectedGender = value.toString();
          if (hint.toLowerCase() == 'result') selectedResult = value.toString();
        }),
        buttonHeight: 42,
        buttonWidth: double.maxFinite,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
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
          birthDate.text = "${selected.day} / ${selected.month} / ${selected.year}";
        }
        if (field == 'result') {
          resultDate.text = "${selected.day} / ${selected.month} / ${selected.year}";
        }
      });
    }
  }

  updatePatient() async {
    final PatientModel patientData = PatientModel(
      fullName: '${firstName.text} ${lastName.text}',
      passportNumber: idNumber.text,
      dateOfBirth: birthDate.text,
      gender: selectedGender!,
      nationality: nationality.text,
      result: selectedResult!,
      resultTakenDate: resultDate.text,
    );

    setState(() => loading = true);

    OperationStatus updateResult = await DatabaseManager.updateUser(patient: patientData);

    if (updateResult == OperationStatus.updateSuccess) {
      Navigator.of(context).pop();
      displaySnackBar(
        context,
        messageDescription: 'Data updated successfully.',
        cardBgColor: Colors.green,
        iconData: Icons.check,
        messageTitle: 'Success',
      );
    } else {
      displaySnackBar(
        context,
        messageDescription: 'There is a problem, please try again!',
        messageTitle: 'Unknown Error',
      );
    }
    setState(() => loading = false);
  }
}
