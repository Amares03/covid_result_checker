import 'package:covid_result_checker/firebase_options.dart';
import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/pages/register_view.dart';
import 'package:covid_result_checker/pages/verify_view.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result Checker',
      home: FirstScreenHandler(),
    ),
  );
}

class FirstScreenHandler extends StatelessWidget {
  const FirstScreenHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const HomePage();
              } else {
                return const VerifyView();
              }
            } else {
              return const LoginView();
            }
          default:
            return Scaffold(
              body: Column(
                children: [
                  const SizedBox(height: 100),
                  const HeaderWidget(),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: Colours.mainColor,
                  ),
                ],
              ),
            );
        }
      },
    );
  }
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
          backgroundColor: bgColor ?? Colors.orange,
          content: Text(title, textAlign: TextAlign.center),
          duration: const Duration(milliseconds: 1700),
        ),
      );
  }

  static Future<void> showErrorDialog({
    required String message,
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occured!'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
