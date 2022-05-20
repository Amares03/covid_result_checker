import 'package:covid_result_checker/helper/database_manager.dart';
import 'package:covid_result_checker/helper/user_model.dart';
import 'package:covid_result_checker/services/apiFunctions.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

ApiFunction apiFunction = ApiFunction();

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  late Future<List<PatientModel>> patient;

  @override
  void initState() {
    patient = DatabaseManager.viewAllPatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALL USERS"),
      ),
      body: FutureBuilder(
        future: patient,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<PatientModel> patientList =
                snapshot.data! as List<PatientModel>;
            return buildUser(patientList);
          } else if (snapshot.hasError) {
            print('no boy');
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitThreeInOut(
                color: Colours.mainColor,
              ),
              const SizedBox(height: 20),
              const Text('Loading All Data from Database'),
            ],
          );
        },
      ),
    );
  }

  Future<void> updateData(PatientModel patient) async {
    final patientData = PatientModel(
      fullName: patient.fullName,
      passportNumber: patient.passportNumber,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      nationality: patient.nationality,
      result: patient.result,
      resultTakenDate: patient.resultTakenDate,
    );
    await DatabaseManager.addNewPatient(patient: patientData);
  }

  buildUser(List<PatientModel> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            title: Text(user.passportNumber),
            trailing: SizedBox(
              width: 200,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DeleteUser(
                            passNumber: users[index].passportNumber);
                      }));
                    },
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return UpdateUser(patient: users[index]);
                      }));
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key, required this.passNumber}) : super(key: key);

  final String passNumber;

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  late TextEditingController fullName;
  @override
  void initState() {
    fullName = TextEditingController();
    fullName.text = widget.passNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update patient data'),
      ),
      body: Column(
        children: [
          TextField(
            controller: fullName,
          ),
          TextButton(
            onPressed: () async {
              await DatabaseManager.deleteUser(passNumber: widget.passNumber);
            },
            child: const Text('Delete patient Data'),
          ),
        ],
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update patient data'),
      ),
      body: Column(
        children: [
          TextField(
            controller: fullName,
          ),
          TextButton(
            onPressed: () async {
              final patientData = PatientModel(
                fullName: fullName.text,
                passportNumber: widget.patient.passportNumber,
                dateOfBirth: widget.patient.dateOfBirth,
                gender: widget.patient.gender,
                nationality: widget.patient.nationality,
                result: widget.patient.result,
                resultTakenDate: widget.patient.resultTakenDate,
              );
              await DatabaseManager.updateUser(patient: patientData);
            },
            child: const Text('Update patient Data'),
          ),
        ],
      ),
    );
  }
}
