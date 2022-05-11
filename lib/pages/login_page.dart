import 'package:covid_result_checker/main.dart';
import 'package:covid_result_checker/widgets/big_text.dart';
import 'package:covid_result_checker/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

// use this colors
// 1ab7c3
// 707070
// ffffff
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/logo.png',
                height: 140,
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Wrap(
                children: const [
                  BigText(text: 'CO'),
                  BigText(text: 'V', color: Colors.red),
                  BigText(text: 'ID RESULT'),
                ],
              ),
              const SizedBox(height: 5),
              const BigText(text: 'CHECKER'),
              const SizedBox(height: 50),
              MyTextField(
                controller: emailController,
                hintText: 'example@example.com',
                title: 'Company email',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: passwordController,
                title: 'Company password',
                hintText: 'Company\'s service number',
                keyboardType: TextInputType.visiblePassword,
                icon: Icons.lock,
              ),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    minimumSize: const Size(double.maxFinite, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      CommonMethods.displaySnackBar(context, title: 'Email can\'t be empty!');
                    } else if (!emailController.text.contains('@') ||
                        !emailController.text.contains('.')) {
                      CommonMethods.displaySnackBar(
                        context,
                        title: 'Make sure your email is correct',
                      );
                    } else if (passwordController.text.isEmpty) {
                      CommonMethods.displaySnackBar(context, title: 'Password can\'t be empty!');
                    } else if (passwordController.text.length <= 4) {
                      CommonMethods.displaySnackBar(
                        context,
                        title: 'Password length must be greater than 4!',
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
