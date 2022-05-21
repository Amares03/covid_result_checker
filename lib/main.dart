import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/pages/verify_view.dart';
import 'package:covid_result_checker/services/auth/auth_services.dart';
import 'package:covid_result_checker/services/auth/auth_user.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'widgets/header_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result Checker',
      theme: ThemeData(
        fontFamily: 'Foo-Regular',
      ),
      home: const FirstScreenHandler(),
    ),
  );
}

class FirstScreenHandler extends StatelessWidget {
  const FirstScreenHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthServices.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final AuthUser? user = AuthServices.firebase().currentUser;

            if (user != null) {
              if (user.isEmailVerified) {
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
                  SpinKitThreeInOut(color: Colours.mainColor),
                ],
              ),
            );
        }
      },
    );
  }
}

class CommonMethods {
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
