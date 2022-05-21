import 'package:covid_result_checker/helper/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../components/display_snackbar.dart';
import '../helper/database_manager.dart';
import '../services/enums.dart';
import '../utils/colors.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key, required this.patient}) : super(key: key);
  final PatientModel patient;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController fullName;
  @override
  void initState() {
    fullName = TextEditingController();
    fullName.text = widget.patient.fullName;
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update patient data'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              TextField(controller: fullName),
              TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final patientData = PatientModel(
                    fullName: fullName.text,
                    passportNumber: widget.patient.passportNumber,
                    dateOfBirth: widget.patient.dateOfBirth,
                    gender: widget.patient.gender,
                    nationality: widget.patient.nationality,
                    result: widget.patient.result,
                    resultTakenDate: widget.patient.resultTakenDate,
                  );
                  OperationStatus result = await DatabaseManager.updateUser(
                    patient: patientData,
                  );

                  if (result == OperationStatus.updateSuccess) {
                    displaySnackBar(
                      context,
                      messageTitle: 'Success!',
                      messageDescription: 'Patient data updated.',
                      cardBgColor: Colors.green,
                      iconName: 'success',
                    );
                    Navigator.pop(context);
                  } else if (result == OperationStatus.updateFailed) {}
                },
                child: const Text('Update patient Data'),
              ),
            ],
          ),
          if (isLoading) SpinKitThreeInOut(color: Colours.mainColor),
        ],
      ),
    );
  }
}
