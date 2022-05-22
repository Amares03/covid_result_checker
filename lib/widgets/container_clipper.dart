import 'package:flutter/material.dart' show BuildContext, CustomClipper, Path, Size;

class ContainerClipper extends CustomClipper<Path> {
  final BuildContext context;

  ContainerClipper({required this.context});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 150);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
