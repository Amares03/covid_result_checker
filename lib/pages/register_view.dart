import 'package:covid_result_checker/main.dart';
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
                        final email = this.email.text.trim();
                        final password = this.password.text.trim();
                        final conPassword = this.conPassword.text.trim();

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
                            setState(() {
                              isLoading = true;
                            });
                            await AuthServices.firebase().register(
                              email: email,
                              password: password,
                            );
                            changeLodingState(false);
                            await AuthServices.firebase()
                                .sendEmailVerification();

                            Navigator.of(context).push(
                              PageTransition(
                                child: const VerifyView(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          } on WeakPasswordAuthException {
                            changeLodingState(false);
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'Weak password is detected!',
                            );
                          } on EmailAlreadyInUseAuthException {
                            changeLodingState(false);
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'Email already used!',
                            );
                          } on InvalidEmailAuthException {
                            changeLodingState(false);
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'Invalid email detected!',
                            );
                          } on GenericAuthException {
                            changeLodingState(false);
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'ErrorCode: Authentication Error',
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
    );
  }
}
