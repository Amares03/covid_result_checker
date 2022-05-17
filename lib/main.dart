import 'package:covid_result_checker/firebase_options.dart';
import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/pages/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
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
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const HomePage();
              } else {
                // goto verify email view for let make it empty
                return const RegisterView();
              }
            } else {
              return const LoginView();
            }
          default:
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      }),
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
          backgroundColor: bgColor ?? Colors.blueGrey,
          content: Text(title, textAlign: TextAlign.center),
          duration: const Duration(milliseconds: 1700),
        ),
      );
  }
}
