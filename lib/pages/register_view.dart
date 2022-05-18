import 'package:covid_result_checker/main.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/pages/verify_view.dart';
import 'package:covid_result_checker/widgets/big_button.dart';
import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:covid_result_checker/widgets/form_background_card.dart';
import 'package:covid_result_checker/widgets/header_widget.dart';
import 'package:covid_result_checker/widgets/my_custom_scaffold.dart';
import 'package:covid_result_checker/widgets/small_button.dart';
import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:covid_result_checker/widgets/txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController conPassword;

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

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const HeaderWidget(),
              const SizedBox(height: 70),
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
                        final email = this.email.text;
                        final password = this.password.text;
                        final conPassword = this.conPassword.text;

                        if (email.isEmpty ||
                            password.isEmpty ||
                            conPassword.isEmpty) {
                          CommonMethods.displaySnackBar(
                            context,
                            title: 'Please fill the fields first.',
                          );
                        } else if (password != conPassword) {
                          CommonMethods.displaySnackBar(
                            context,
                            title: 'password does not match',
                          );
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            final user = FirebaseAuth.instance.currentUser;
                            await user?.sendEmailVerification();
                            PageTransition(
                              child: const VerifyView(),
                              type: PageTransitionType.rightToLeft,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              CommonMethods.displaySnackBar(
                                context,
                                title:
                                    'password is weak, please use stronger one.',
                              );
                            } else if (e.code == 'email-already-in-use') {
                              CommonMethods.displaySnackBar(
                                context,
                                title:
                                    'Email already in use, please use another one.',
                              );
                            } else if (e.code == 'invalid-email') {
                              CommonMethods.displaySnackBar(
                                context,
                                title:
                                    'Email is invalid. please use a valid one.',
                              );
                            }
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
            ],
          ),
        ),
      ),
    );
  }
}
