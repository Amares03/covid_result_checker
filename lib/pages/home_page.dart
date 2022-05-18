// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:covid_result_checker/pages/all_users.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/widgets/form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

enum FormType { AddUser, UpdateUser, DeleteUser, AllUser }

enum MenuAction { logOut }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Colours.mainColor,
        actions: [
          PopupMenuButton<MenuAction>(
            color: Colors.white,
            icon: Icon(Icons.logout),
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logOut:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: LoginView(),
                        type: PageTransitionType.leftToRight,
                      ),
                      (route) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logOut,
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EditingButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFormField(formType: FormType.AddUser),
                ),
              );
            },
            color: Colors.green,
            text: 'Create a user',
          ),
          SizedBox(height: 20),
          EditingButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyFormField(formType: FormType.UpdateUser),
                ),
              );
            },
            color: Colors.red,
            text: 'Update a user',
          ),
          SizedBox(height: 20),
          EditingButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyFormField(formType: FormType.DeleteUser),
                ),
              );
            },
            color: Colors.blue,
            text: 'delete a user',
          ),
          SizedBox(height: 20),
          EditingButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllUsers(),
                ),
              );
            },
            color: Color.fromARGB(255, 1, 8, 14),
            text: 'view all users',
          ),
        ],
      ),
    );
  }
}

class EditingButton extends StatelessWidget {
  const EditingButton({
    Key? key,
    required this.color,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 20),
        color: color,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
