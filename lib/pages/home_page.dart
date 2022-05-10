// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page title"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EditingButton(
            onTap: () {},
            color: Colors.green,
            text: 'Create a user',
          ),
          SizedBox(height: 20),
          EditingButton(
            onTap: () {},
            color: Colors.red,
            text: 'Update a user',
          ),
          SizedBox(height: 20),
          EditingButton(
            onTap: () {},
            color: Colors.blue,
            text: 'delete a user',
          ),
        ],
      ),
    );
  }
}

class EditingButton extends StatelessWidget {
  const EditingButton({
    Key? key,
    required this.color,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 20),
        color: color,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
