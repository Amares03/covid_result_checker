import 'package:flutter/material.dart';

class SkewCut extends CustomClipper<Path> {
  final BuildContext context;

  SkewCut(this.context);
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 100);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(SkewCut oldClipper) => false;
}
