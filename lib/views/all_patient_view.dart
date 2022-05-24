import 'package:covid_result_checker/db/user_model.dart';
import 'package:covid_result_checker/views/update_patient_view.dart';
import 'package:covid_result_checker/widgets/loading_widget.dart';
import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../db/database_manager.dart';
import '../utils/colors.dart';
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
        final PatientModel patient = patientList[index];
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
                onPressed: () async {
                  final shouldUpdate = await updateDialog(context);
                  if (shouldUpdate) {
                    Navigator.of(context).pushReplacementNamed(UpdatePatientView.routeName, arguments: patient);
                  }
                },
                icon: const Icon(Icons.edit_note),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFdb7634),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              SvgPicture.asset(
                                patient.gender == 'Male' ? 'assets/male.svg' : 'assets/female.svg',
                                height: 45,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                patient.fullName.toUpperCase(),
                                style: const TextStyle(fontSize: 18, letterSpacing: 1, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '@' + patient.passportNumber,
                                style: const TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white54),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SmallText(
                                          text: 'Result',
                                        ),
                                        Container(
                                          height: 45,
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colours.mainColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              patient.result,
                                              style:
                                                  const TextStyle(fontSize: 18, letterSpacing: 1, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SmallText(
                                          text: 'Result taken date',
                                        ),
                                        Container(
                                          height: 45,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: Colours.mainColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Center(
                                            child: Text(
                                              patient.resultTakenDate,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SmallText(
                                          text: 'Gender',
                                        ),
                                        Container(
                                          height: 45,
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colours.mainColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              patient.gender,
                                              style:
                                                  const TextStyle(fontSize: 18, letterSpacing: 1, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SmallText(
                                          text: 'Date of birth',
                                        ),
                                        Container(
                                          height: 45,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: Colours.mainColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Center(
                                            child: Text(
                                              patient.dateOfBirth,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              horizontalTitleGap: 30,
            ),
            const Divider(height: 0, thickness: 1),
          ],
        );
      },
    );
  }
}

Future<bool> updateDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Update record'),
        content: const Text('Are you sure to edit this data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colours.secondaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Edit & update',
              style: TextStyle(color: Color(0xFFdb7634)),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
