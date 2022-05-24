import 'package:covid_result_checker/db/user_model.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/views/all_patient_view.dart';
import 'package:covid_result_checker/views/login_view.dart';
import 'package:covid_result_checker/views/patient_register_view.dart';
import 'package:covid_result_checker/widgets/display_snackbar.dart';
import 'package:covid_result_checker/widgets/loading_widget.dart';
import 'package:covid_result_checker/widgets/patient_info_text_field.dart';
import 'package:covid_result_checker/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';

import '../db/database_manager.dart';
import '../services/auth_services.dart';
import '../widgets/qr_scanner_button.dart';
import '../widgets/task_button.dart';
import 'update_patient_view.dart';

enum MenuAction { logOut }

class HomeView extends StatefulWidget {
  static const String routeName = '/home/';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController controller;

  bool loading = false;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      height: 240,
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: loading ? Colors.black.withOpacity(0.2) : Colors.transparent,
          elevation: 0,
          title: Text(
            'Hello, There!',
            style: TextStyle(
              fontFamily: 'Foo-Bold',
              color: Colours.bigTextBlackColor,
            ),
          ),
          actions: [
            PopupMenuButton<MenuAction>(
              position: PopupMenuPosition.under,
              color: Colors.white,
              icon: Icon(Icons.segment, color: Colours.bigTextBlackColor),
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logOut:
                    final shouldLogout = await showLogoutDialog(context);
                    if (shouldLogout) {
                      AuthServices.firebase().logout();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginView.routeName,
                        (route) => false,
                      );
                    }
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: MenuAction.logOut,
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colours.bigTextBlackColor),
                        const SizedBox(width: 5),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colours.bigTextBlackColor),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: Colours.gradient2,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        SizedBox(height: 10),
                        Text(
                          'Attention!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                            fontFamily: 'Foo-Bold',
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            'This product should be used only by proffesionals, specially for health care centers.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              letterSpacing: 1,
                              fontFamily: 'Foo-Bold',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Tasks',
                      style: TextStyle(
                        color: Colours.bigTextBlackColor,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontFamily: 'Foo-Bold',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TaskButton(
                          onTap: () {
                            Navigator.pushNamed(context, PatientRegisterView.routeName);
                          },
                          color: const Color(0xFF628ec5),
                          icon: Icons.post_add,
                          title: 'Register',
                          desc: 'Create new patient record.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TaskButton(
                          onTap: () async {
                            var shouldUpdate = await updateDialog(context: context);
                            if (shouldUpdate) {
                              setState(() {
                                loading = true;
                              });
                              final patient = await DatabaseManager.getSinglePatientModel(id: controller.text);

                              if (patient is PatientModel) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.of(context).pushNamed(UpdatePatientView.routeName, arguments: patient);
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                displaySnackBar(context, messageDescription: 'No record found');
                              }
                            }
                          },
                          icon: Icons.update,
                          color: const Color(0xffb774bd),
                          title: 'Update',
                          desc: 'Alter an existing record.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TaskButton(
                          onTap: () {
                            Navigator.pushNamed(context, AllPatienView.routeName);
                          },
                          color: const Color(0xFFdb7634),
                          icon: Icons.view_list_rounded,
                          title: 'View All',
                          desc: 'Display all records from database.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TaskButton(
                          onTap: () {},
                          icon: Icons.delete_outline,
                          color: const Color(0xff8866cf),
                          title: 'Delete',
                          desc: 'Remove an existing record from database.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Find Records Using',
                    style: TextStyle(
                      color: Colours.bigTextBlackColor,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontFamily: 'Foo-Bold',
                    ),
                  ),
                  const SizedBox(height: 20),
                  QrScannerButton(
                    onTap: () {},
                  ),
                ],
              ),
            ),
            if (loading)
              Container(
                color: Colors.black.withOpacity(0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LoadingWidget(
                      title: 'Finding',
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<bool> updateDialog({required BuildContext context}) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search user'),
          content: PatientInfoTextField(
            editingController: controller,
            hintText: 'passport or kebele id',
            text: 'Id',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colours.secondaryColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(primary: const Color(0xffb774bd)),
              child: Text(
                'Find',
                style: TextStyle(color: Colors.red.shade800),
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colours.secondaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red.shade800),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
