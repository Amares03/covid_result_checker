import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/widgets/skew_shape.dart';
import 'package:flutter/material.dart';

class MyCustomScaffold extends StatelessWidget {
  const MyCustomScaffold({Key? key, required this.scaffold}) : super(key: key);

  final Widget scaffold;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.maxFinite,
          color: Colors.white,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: SkewCut(context),
            child: Container(
              height: 450,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: Colours.gradient1,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),
        ),
        scaffold,
      ],
    );
  }
}
