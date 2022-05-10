import 'package:covid_result_checker/pages/home_page.dart';
import 'package:flutter/material.dart';

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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log page'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: email,
          decoration: InputDecoration(hintText: 'enter your email'),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: password,
          decoration: InputDecoration(hintText: 'enter your password'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final emails = email.text;
            final passwords = password.text;
            print(emails);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
          child: Text('Login'),
        ),
      ]),
    );
  }
}
