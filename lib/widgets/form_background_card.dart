import 'package:covid_result_checker/utils/styles.dart';
import 'package:flutter/material.dart';

class FormBackgroundCard extends StatelessWidget {
  const FormBackgroundCard({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [Styles.boxShadow],
      ),
      child: child,
    );
  }
}
