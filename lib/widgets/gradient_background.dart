import 'package:covid_result_checker/utils/colors.dart';
import 'package:covid_result_checker/widgets/skew_shape.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              colors: Colours.gradient1,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
    );
  }
}
