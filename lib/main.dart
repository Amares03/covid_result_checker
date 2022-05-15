import 'package:covid_result_checker/pages/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result Checker',
      home: RegisterView(),
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
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: bgColor ?? Colors.blueGrey,
          content: Text(title, textAlign: TextAlign.center),
          duration: const Duration(milliseconds: 1700),
        ),
      );
  }
}
