import 'package:covid_result_checker/services/auth_services.dart';
import 'package:covid_result_checker/views/login_view.dart';
import 'package:covid_result_checker/views/verify_view.dart';
import 'package:flutter/material.dart';

import '../services/auth_exceptions.dart';
import '../utils/colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/big_text.dart';
import '../widgets/display_snackbar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/logo_and_title.dart';
import '../widgets/scaffold_background.dart';
import '../widgets/small_text.dart';
import '../widgets/submit_button.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = '/register/';

  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  bool loading = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

    _password.addListener(() => setState(() {}));
    _confirmPassword.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();

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
                const BigText(text: 'Create new account'),
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
                      const SmallText(text: "New password"),
                      const SizedBox(height: 5),
                      AuthTextField(
                        controller: _password,
                        isPassword: _password.text.isEmpty ? false : true,
                      ),
                      const SizedBox(height: 10),
                      const SmallText(text: "Confirm password"),
                      const SizedBox(height: 5),
                      Hero(
                        tag: 'password',
                        child: AuthTextField(
                          controller: _confirmPassword,
                          isPassword: _confirmPassword.text.isEmpty ? false : true,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Hero(
                        tag: 'big',
                        child: SubmitButton(
                          buttonText: 'Register',
                          onPressed: register,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Already have an account yet? ",
                            style: TextStyle(
                              letterSpacing: 0.8,
                              fontSize: 13,
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginView.routeName,
                                (route) => false,
                              ),
                              child: const Text('Login here.'),
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

  register() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final String email = _email.text.trim().toLowerCase();
    final String password = _password.text.trim().toLowerCase();
    final String confirmPassword = _confirmPassword.text.trim().toLowerCase();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      displaySnackBar(
        context,
        messageDescription: "Email or password can't be empty.",
        messageTitle: 'Empty Field',
        iconData: Icons.block_rounded,
      );
    } else if (password != confirmPassword) {
      displaySnackBar(
        context,
        messageDescription: "Those password didn't match. Try again.",
        messageTitle: 'Password mismatch',
        iconData: Icons.block_rounded,
      );
    } else {
      try {
        setState(() => loading = true);

        await AuthServices.firebase().register(email: email, password: password);

        await AuthServices.firebase().sendEmailVerification();

        setState(() => loading = false);

        Navigator.of(context).pushNamed(VerifyView.routeName);
      } on WeakPasswordAuthException {
        setState(() => loading = false);
        displaySnackBar(
          context,
          messageDescription: 'Use 6 characters or more for your password.',
          messageTitle: 'Weak password',
        );
      } on EmailAlreadyInUseAuthException {
        setState(() => loading = false);
        displaySnackBar(
          context,
          messageDescription: 'The email is taken. Try another.',
          messageTitle: 'Existing email',
        );
      } on InvalidEmailAuthException {
        setState(() => loading = false);
        displaySnackBar(
          context,
          messageDescription: 'The email is invalid. Try another',
          messageTitle: 'Invalid email',
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
