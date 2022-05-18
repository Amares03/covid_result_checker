import 'dart:async';

import 'package:covid_result_checker/pages/home_page.dart';
import 'package:covid_result_checker/pages/login_view.dart';
import 'package:covid_result_checker/utils/colors.dart';
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
  bool isVerified = false;

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
      setState(() {
        isVerified = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isVerified
            ? const SizedBox()
            : BackButton(
                color: Colors.grey.shade600,
              ),
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
              color: isVerified ? Colors.green : Colours.mainColor,
            ),
          ),
          Text(
            isVerified ? 'Verification Success!' : 'Verify Your Email...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isVerified ? Colors.green : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              isVerified
                  ? 'the email verification was success. click the below button to go to the homepage.'
                  : 'We sent you an email verification link. Please open the link and verify your email address.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const Spacer(),
          if (isVerified == false)
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
            child: isVerified
                ? BigButton(
                    onTap: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                          child: const HomePage(),
                          type: PageTransitionType.rightToLeft,
                        ),
                        (route) => false,
                      );
                    },
                    text: 'Goto Homepage',
                  )
                : BigButton(
                    onTap: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                    },
                    text: 'Send Email Verification',
                  ),
          ),
          const SizedBox(height: 30),
          if (isVerified == false)
            const Text(
              'or',
              style: TextStyle(color: Colors.grey),
            ),
          if (isVerified == false)
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
