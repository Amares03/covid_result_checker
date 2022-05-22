import 'package:covid_result_checker/services/auth_exceptions.dart';
import 'package:covid_result_checker/services/auth_services.dart';
import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/views/home_view.dart';
import 'package:covid_result_checker/views/register_view.dart';
import 'package:covid_result_checker/views/verify_view.dart';
import 'package:covid_result_checker/widgets/auth_text_field.dart';
import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:covid_result_checker/widgets/display_snackbar.dart';
import 'package:covid_result_checker/widgets/logo_and_title.dart';
import 'package:covid_result_checker/widgets/scaffold_background.dart';
import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/loading_widget.dart';
import '../widgets/submit_button.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login/';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool loading = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _password.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 70),
                const LogoAndTitle(),
                const SizedBox(height: 60),
                const BigText(text: 'Welcome back!'),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmallText(text: "Organization email"),
                      const SizedBox(height: 5),
                      AuthTextField(controller: _email),
                      const SizedBox(height: 10),
                      const SmallText(text: "Password"),
                      const SizedBox(height: 5),
                      Hero(
                        tag: 'password',
                        child: AuthTextField(
                          controller: _password,
                          isPassword: _password.text.isEmpty ? false : true,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Hero(
                        tag: 'big',
                        child: SubmitButton(
                          buttonText: 'Login',
                          onPressed: login,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Don't have an account yet? ",
                            style: TextStyle(
                              letterSpacing: 0.8,
                              fontSize: 13,
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                RegisterView.routeName,
                                (route) => false,
                              ),
                              child: const Text('Register here.'),
                              style: TextButton.styleFrom(
                                primary: Colours.mainColor,
                                textStyle: const TextStyle(letterSpacing: 1, fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                if (loading) const LoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    // hide keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    final String email = _email.text.trim();
    final String password = _password.text.trim();

    if (email.isEmpty || password.isEmpty) {
      displaySnackBar(
        context,
        messageDescription: "Email or password can't be empty.",
        messageTitle: 'Empty Field',
        iconData: Icons.block_rounded,
      );
    } else {
      try {
        setState(() => loading = true);

        await AuthServices.firebase().login(email: email, password: password);

        final currentUser = AuthServices.firebase().currentUser;

        setState(() => loading = false);

        if (currentUser?.isEmailVerified ?? false) {
          Navigator.of(context).pushNamedAndRemoveUntil(HomeView.routeName, (route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(VerifyView.routeName, (route) => false);
        }
      } on UserNotFoundAuthException {
        setState(() => loading = false);
        displaySnackBar(
          context,
          messageDescription: "Couldn't find your account.",
          messageTitle: 'No Account',
          iconData: Icons.block_rounded,
        );
      } on WrongPasswordAuthException {
        setState(() => loading = false);
        displaySnackBar(
          context,
          messageDescription: 'Wrong password, Please try again!',
          messageTitle: 'Wrong password',
        );
      } on GenericAuthException {
        setState(() => loading = false);
        displaySnackBar(
          context,
          messageDescription: 'There is a problem, please try again!',
          messageTitle: 'Unknown Error',
        );
      }
    }
  }
}
