import 'package:covid_result_checker/widgets/big_button.dart';
import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:covid_result_checker/widgets/form_background_card.dart';
import 'package:covid_result_checker/widgets/gradient_background.dart';
import 'package:covid_result_checker/widgets/header_widget.dart';
import 'package:covid_result_checker/widgets/small_button.dart';
import 'package:covid_result_checker/widgets/small_text.dart';
import 'package:covid_result_checker/widgets/txt_field.dart';
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                    child: SingleChildScrollView(
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
                          ),
                          const SizedBox(height: 15),
                          const SmallText(text: 'Confirm service number'),
                          const SizedBox(height: 5),
                          TxTField(
                            editingController: confirmController,
                            hintText: 'confirm service number',
                          ),
                          const SizedBox(height: 20),
                          // register button
                          BigButton(
                            onTap: () {},
                            text: 'Register',
                          ),
                          const SizedBox(height: 10),
                          // optional login button
                          SmallButton(
                            onPressed: () {},
                            longText: 'Already have an account? ',
                            buttonText: 'Login here.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
