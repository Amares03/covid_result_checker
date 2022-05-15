import 'package:flutter/material.dart'
    show BoxShadow, Colors, BlurStyle, Offset;

class Styles {
  static BoxShadow boxShadow = const BoxShadow(
    color: Colors.black26,
    blurRadius: 3,
    spreadRadius: 5,
    blurStyle: BlurStyle.outer,
    offset: Offset(0, 3),
  );
}
