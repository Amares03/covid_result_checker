import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/widgets/big_button.dart';
import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:covid_result_checker/widgets/form_background_card.dart';
import 'package:covid_result_checker/widgets/gradient_background.dart';
import 'package:covid_result_checker/widgets/header_widget.dart';
import 'package:covid_result_checker/widgets/small_button.dart';
import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:covid_result_checker/widgets/txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: double.maxFinite, color: Colors.white),
        const GradientBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const HeaderWidget(),
                const SizedBox(height: 50),
                const BigText(
                  text: 'Register a new account',
                  fontSize: 20,
                ),
                const SizedBox(height: 25),
                FormBackgroundCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmallText(
                        text: 'Company\'s Email',
                      ),
                      const SizedBox(height: 5),
                      TxTField(
                        editingController: emailController,
                        hintText: 'example@mailservice.com',
                      ),
                      const SizedBox(height: 15),
                      const SmallText(text: 'Service number'),
                      const SizedBox(height: 5),
                      TxTField(
                        editingController: passwordController,
                        hintText: 'official service number',
                        isPassword: true,
                      ),
                      const SizedBox(height: 15),
                      const SmallText(text: 'Confirm service number'),
                      const SizedBox(height: 5),
                      TxTField(
                        editingController: confirmController,
                        hintText: 'confirm service number',
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      // register button
                      BigButton(
                        onTap: () async {
                          final email = emailController.text;
                          final password = passwordController.text;
                          final comfirm = confirmController.text;

                          if (password == comfirm &&
                              password.isNotEmpty &&
                              comfirm.isNotEmpty &&
                              email.isNotEmpty) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              final user = FirebaseAuth.instance.currentUser;
                              await user?.sendEmailVerification();
                              Navigator.of(context).pushNamed('/verify/');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                await showErrorDialog(
                                  message: 'Weak password entered',
                                  context: context,
                                );
                              } else if (e.code == 'email-already-in-use') {
                                await showErrorDialog(
                                  message: 'Email already in use, try another!',
                                  context: context,
                                );
                              } else if (e.code == 'invalid-email') {
                                await showErrorDialog(
                                  message: 'Invalid email used',
                                  context: context,
                                );
                              }
                            }
                          } else {
                            if (email.isEmpty) {
                              await showErrorDialog(
                                message: 'Email field can not be left blank.',
                                context: context,
                              );
                            } else if (!email.contains('@') ||
                                !email.contains('.')) {
                              await showErrorDialog(
                                message: 'Invalid email address used.',
                                context: context,
                              );
                            } else if (password.isEmpty || comfirm.isEmpty) {
                              await showErrorDialog(
                                message: 'Please fill the password field.',
                                context: context,
                              );
                            } else if (password != comfirm) {
                              await showErrorDialog(
                                message: 'Password field does\'nt match.',
                                context: context,
                              );
                            }
                          }
                        },
                        text: 'Register',
                      ),
                      const SizedBox(height: 10),
                      // optional login button
                      SmallButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                        },
                        longText: 'Already have an account? ',
                        buttonText: 'Login here.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
