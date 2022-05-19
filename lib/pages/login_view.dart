import 'package:covid_result_checker/main.dart';
import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/pages/register_view.dart';
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

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController email;
  late final TextEditingController password;
  bool isLoading = false;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    password.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
                const SizedBox(height: 100),
                const BigText(text: 'Welcome back!'),
                const SizedBox(height: 20),
                FormBackgroundCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SmallText(text: "company's email"),
                      const SizedBox(height: 5),
                      TxTField(
                        hintText: '',
                        editingController: email,
                      ),
                      const SizedBox(height: 15),
                      const SmallText(text: "service number (password)"),
                      const SizedBox(height: 5),
                      TxTField(
                        hintText: '',
                        editingController: password,
                        isPassword: password.text.isNotEmpty ? true : false,
                      ),
                      const SizedBox(height: 20),
                      BigButton(
                        text: 'Login',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );
                          final email = this.email.text.trim();
                          final password = this.password.text.trim();
                          // make sure the fields are not empty
                          if (email.isEmpty || password.isEmpty) {
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'email or password can\'t be empty.',
                            );
                          } else {
                            try {
                              // create a new user
                              setState(() {
                                isLoading = true;
                              });
                              await AuthServices.firebase().login(
                                email: email,
                                password: password,
                              );

                              final user = AuthServices.firebase().currentUser;
                              changeLodingState(false);
                              // make sure email is verified before going to homepage
                              if (user?.isEmailVerified ?? false) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  PageTransition(
                                    child: const HomePage(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                  (route) => false,
                                );
                              } else {
                                // if email is not verified goto verify page
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: const VerifyView(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              }
                              // this are exceptions that will happen during authentication
                            } on UserNotFoundAuthException {
                              changeLodingState(false);
                              CommonMethods.displaySnackBar(
                                context,
                                title: 'User not found!',
                              );
                            } on WrongPasswordAuthException {
                              changeLodingState(false);
                              CommonMethods.displaySnackBar(
                                context,
                                title: 'wrong password detected!',
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
                      // A littel text button that take us to Registration page
                      SmallButton(
                        longText: "Don't have an account yet?",
                        buttonText: 'Signup here',
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            PageTransition(
                              child: const RegisterView(),
                              type: PageTransitionType.fade,
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                isLoading
                    ? const SpinKitThreeInOut(
                        color: Colors.white,
                        size: 40,
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
