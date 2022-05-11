import 'package:covid_result_checker/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result Checker',
      home: LoginPage(),
    ),
  );
}

class CommonMethods {
  static ScaffoldMessengerState displaySnackBar(
    BuildContext context, {
    required String title,
    Color? bgColor,
  }) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor ?? Colors.grey,
          content: Text(title, textAlign: TextAlign.center),
          duration: const Duration(milliseconds: 1700),
        ),
      );
  }
}
