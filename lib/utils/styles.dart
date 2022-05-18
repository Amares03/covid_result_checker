import 'package:flutter/material.dart'
    show BoxShadow, Colors, BlurStyle, Offset;

class Styles {
  static BoxShadow boxShadow = const BoxShadow(
    color: Colors.black12,
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(0, 3),
  );
}
