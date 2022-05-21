import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/pages/verify_view.dart';
import 'package:covid_result_checker/services/auth/auth_exceptions.dart';
import 'package:covid_result_checker/services/auth/auth_services.dart';
import 'package:covid_result_checker/widgets/big_button.dart';
import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:covid_result_checker/widgets/form_background_card.dart';
import 'package:covid_result_checker/widgets/header_widget.dart';
import 'package:covid_result_checker/widgets/my_custom_scaffold.dart';
import 'package:covid_result_checker/widgets/small_button.dart';
import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:covid_result_checker/widgets/txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../components/display_snackbar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController conPassword;
  bool isLoading = false;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    conPassword = TextEditingController();

    password.addListener(() => setState(() {}));
    conPassword.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    conPassword.dispose();
    super.dispose();
  }

  changeLodingState(newState) {
    setState(() {
      isLoading = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const HeaderWidget(),
                const SizedBox(height: 50),
                const BigText(text: 'Create new account'),
                const SizedBox(height: 20),
                FormBackgroundCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SmallText(text: "company's email"),
                      const SizedBox(height: 5),
                      TxTField(
                        hintText: 'example@gmail.com',
                        editingController: email,
                      ),
                      const SizedBox(height: 15),
                      const SmallText(text: "password"),
                      const SizedBox(height: 5),
                      TxTField(
                        hintText: 'password',
                        editingController: password,
                        isPassword: password.text.isNotEmpty ? true : false,
                      ),
                      const SizedBox(height: 15),
                      const SmallText(text: "confirm"),
                      const SizedBox(height: 5),
                      TxTField(
                        hintText: 'confirm password',
                        editingController: conPassword,
                        isPassword: conPassword.text.isNotEmpty ? true : false,
                      ),
                      const SizedBox(height: 20),
                      BigButton(
                        text: 'Sign up',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );
                          final email = this.email.text.trim();
                          final password = this.password.text.trim();
                          final conPassword = this.conPassword.text.trim();

                          if (email.isEmpty || password.isEmpty || conPassword.isEmpty) {
                            displaySnackBar(
                              context,
                              messageDescription: 'Make sure you filled all the fields.',
                            );
                          } else if (password != conPassword) {
                            displaySnackBar(
                              context,
                              messageDescription: 'Make sure you entered the same password.',
                            );
                          } else {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await AuthServices.firebase().register(
                                email: email,
                                password: password,
                              );
                              changeLodingState(false);
                              await AuthServices.firebase().sendEmailVerification();

                              Navigator.of(context).push(
                                PageTransition(
                                  child: const VerifyView(),
                                  type: PageTransitionType.rightToLeft,
                                ),
                              );
                            } on WeakPasswordAuthException {
                              changeLodingState(false);
                              displaySnackBar(
                                context,
                                messageDescription: 'Your password is weak, please use another one.',
                              );
                            } on EmailAlreadyInUseAuthException {
                              changeLodingState(false);
                              displaySnackBar(
                                context,
                                messageDescription: 'The email is already taken, please use another one.',
                              );
                            } on InvalidEmailAuthException {
                              changeLodingState(false);
                              displaySnackBar(
                                context,
                                messageDescription: 'Your email is invalid, please use another one',
                              );
                            } on GenericAuthException {
                              changeLodingState(false);
                              displaySnackBar(
                                context,
                                messageDescription: 'ErrorCode: Something terrible happend, please reload the page.',
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      SmallButton(
                        longText: "Already have an account?",
                        buttonText: 'Login here',
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            PageTransition(
                              child: const LoginView(),
                              type: PageTransitionType.fade,
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const SpinKitThreeInOut(
                        color: Colors.white,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
