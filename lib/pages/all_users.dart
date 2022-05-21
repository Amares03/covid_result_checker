import 'package:covid_result_checker/components/display_snackbar.dart';
import 'package:covid_result_checker/helper/database_manager.dart';
import 'package:covid_result_checker/helper/user_model.dart';
import 'package:covid_result_checker/pages/update_patient_data.dart';
import 'package:covid_result_checker/services/apiFunctions.dart';
import 'package:covid_result_checker/services/enums.dart';
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    patient = DatabaseManager.viewAllPatient();
    super.didChangeDependencies();
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
          return Container(
            color: Colors.black.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeInOut(
                  color: Colours.mainColor,
                ),
                const SizedBox(height: 20),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colours.mainColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  buildUser(List<PatientModel> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          onTap: () {},
          // contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          leading: Container(
            child: user.gender == 'Female'
                ? const Icon(Icons.female_outlined)
                : const Icon(Icons.male),
          ),
          title: Text(user.fullName),
          subtitle: Text(user.resultTakenDate),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DeleteUser(
                            passNumber: users[index].passportNumber,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.delete_outline_rounded),
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return UpdateUser(patient: users[index]);
                      }),
                    );
                  },
                  icon: const Icon(Icons.edit_note_outlined),
                ),
              ],
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
              TextField(
                controller: fullName,
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await DatabaseManager.deleteUser(
                    passNumber: widget.passNumber,
                  );
                },
                child: const Text('Delete patient Data'),
              ),
            ],
          ),
          if (isLoading) SpinKitThreeInOut(color: Colours.mainColor),
        ],
      ),
    );
  }
}
