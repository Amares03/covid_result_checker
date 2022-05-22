import 'package:covid_result_checker/views/home_view.dart';
import 'package:covid_result_checker/views/patient_register_view.dart';
import 'package:covid_result_checker/views/register_view.dart';
import 'package:covid_result_checker/widgets/logo_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import 'services/auth_services.dart';
import 'services/auth_user.dart';
import 'utils/colors.dart';
import 'views/login_view.dart';
import 'views/verify_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result Checker',
      theme: ThemeData(
        fontFamily: 'Foo-Regular',
      ),
      home: const FirstScreenHandler(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RegisterView.routeName:
            return PageTransition(
              child: const RegisterView(),
              type: PageTransitionType.fade,
              curve: Curves.easeIn,
              settings: settings,
            );
          case LoginView.routeName:
            return PageTransition(
              child: const LoginView(),
              type: PageTransitionType.fade,
              curve: Curves.easeOut,
              settings: settings,
            );
          case VerifyView.routeName:
            return PageTransition(
              child: const VerifyView(),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
              settings: settings,
            );
          case HomeView.routeName:
            return PageTransition(
              child: const HomeView(),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
              settings: settings,
            );
          case PatientRegisterView.routeName:
            return PageTransition(
              child: const PatientRegisterView(),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
              settings: settings,
            );
          default:
            return null;
        }
      },
    );
  }
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
                return const HomeView();
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
                  const SizedBox(height: 70),
                  const LogoAndTitle(),
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
