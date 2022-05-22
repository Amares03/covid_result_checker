import 'package:covid_result_checker/db/user_model.dart';
import 'package:covid_result_checker/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../db/database_manager.dart';
import '../widgets/display_snackbar.dart';

class AllPatienView extends StatefulWidget {
  static const String routeName = '/allPatientView/';

  const AllPatienView({Key? key}) : super(key: key);

  @override
  State<AllPatienView> createState() => _AllPatienViewState();
}

class _AllPatienViewState extends State<AllPatienView> {
  late Future<List<PatientModel>> patientModelList;

  @override
  void initState() {
    patientModelList = DatabaseManager.viewAllPatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdb7634),
        title: const Text('Patient List'),
      ),
      body: FutureBuilder(
        future: patientModelList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<PatientModel> patientList = snapshot.data as List<PatientModel>;
            return buildPatient(patientList: patientList);
          } else if (snapshot.hasError) {
            displaySnackBar(
              context,
              messageDescription: 'There is a problem, please try again!',
              messageTitle: 'Unknown Error',
            );
            print(snapshot.error);
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              LoadingWidget(
                title: 'Loading',
                color: Color(0xFFdb7634),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildPatient({required List<PatientModel> patientList}) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: patientList.length,
      itemBuilder: (context, index) {
        final patient = patientList[index];
        return Column(
          children: [
            ListTile(
              leading: SvgPicture.asset(
                patient.gender == 'Male' ? 'assets/male.svg' : 'assets/female.svg',
                height: 45,
              ),
              title: Text(
                patient.fullName,
                style: const TextStyle(letterSpacing: 1),
              ),
              subtitle: Text(patient.dateOfBirth),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_note),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              onTap: () {},
              horizontalTitleGap: 30,
            ),
            const Divider(height: 0, thickness: 1),
          ],
        );
      },
    );
  }
}
