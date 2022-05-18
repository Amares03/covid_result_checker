import 'dart:async';

import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/widgets/big_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class VerifyView extends StatefulWidget {
  const VerifyView({Key? key}) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 2),
      ((timer) => emailVerified()),
    );
    super.initState();
  }

  emailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified ?? false) {
      timer?.cancel();
      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
          child: const HomePage(),
          type: PageTransitionType.rightToLeft,
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: SvgPicture.asset(
              'assets/verify.svg',
              height: 200,
              width: 100,
            ),
          ),
          Text(
            'Verify Your Email...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'We have sent you an email verification link. Please open the link and verify your email address.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'If you did not received an email click below.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: BigButton(
              onTap: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              text: 'Send Email Verification',
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'or',
            style: TextStyle(color: Colors.grey),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  child: const LoginView(),
                  type: PageTransitionType.leftToRight,
                ),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
