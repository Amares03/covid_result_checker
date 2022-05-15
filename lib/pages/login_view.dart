import 'package:covid_result_checker/widgets/skew_shape.dart';
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
    return Stack(
      children: [
        Container(height: double.maxFinite, color: Colors.white),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: ClipPath(
            clipper: SkewCut(context),
            child: Container(
              height: 350,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade700,
                    Colors.cyan.shade400,
                    Colors.cyan.shade200,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Row(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 120,
                        width: 150,
                      ),
                      Expanded(
                        child: Text(
                          'Covid Result Checker',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Register a new account',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          spreadRadius: 5,
                          blurStyle: BlurStyle.outer,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
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
                            editingController: emailController,
                            hintText: 'official service number',
                          ),
                          const SizedBox(height: 15),
                          const SmallText(text: 'Confirm service number'),
                          const SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade900,
                                  Colors.blue.shade700,
                                  Colors.cyan.shade400,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Login here.',
                                ),
                              ),
                            ],
                          )
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
