import 'package:covid_result_checker/utils/colors.dart';
import 'package:flutter/material.dart';

import 'container_clipper.dart';

class ScaffoldBackground extends StatelessWidget {
  const ScaffoldBackground({Key? key, required this.scaffold, this.height}) : super(key: key);

  final Scaffold scaffold;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: ContainerClipper(context: context),
            child: Container(
              height: height ?? 450,
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
