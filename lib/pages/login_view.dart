import 'package:covid_result_checker/main.dart';
import 'package:covid_result_checker/pages/register_view.dart';
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

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    password.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
                        final email = this.email.text;
                        final password = this.password.text;
                        // make sure the fields are not empty
                        if (email.isEmpty || password.isEmpty) {
                          CommonMethods.displaySnackBar(
                            context,
                            title: 'email or password can\'t be empty.',
                          );
                        }

                        try {
                          // create a new user
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          final user = FirebaseAuth.instance.currentUser;
                          // make sure email is verified before going to homepage
                          if (user?.emailVerified ?? false) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/homepage/',
                              (route) => false,
                            );
                          } else {
                            // if email is not verified goto verify page
                            PageTransition(
                              child: const VerifyView(),
                              type: PageTransitionType.rightToLeft,
                            );
                          }
                          // this are exceptions that will happen during authentication
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'Company not found',
                            );
                          } else if (e.code == 'wrong-password') {
                            CommonMethods.displaySnackBar(
                              context,
                              title: 'Wrong password',
                            );
                          }
                          // this exception is executed when the problem is undefined
                        } catch (_) {
                          CommonMethods.displaySnackBar(
                            context,
                            title: 'Something went wrong.',
                          );
                        }
                      },
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
