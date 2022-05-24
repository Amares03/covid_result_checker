import 'package:flutter/material.dart';

import '../utils/colors.dart';

Future<bool> displayDialog({
  required BuildContext context,
  TextEditingController? controller,
  required String title,
  required Widget child,
  String? cancel,
  required String ok,
  Color? okColor,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: child,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancel ?? 'Cancel',
              style: TextStyle(color: Colours.secondaryColor),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            style: TextButton.styleFrom(primary: const Color(0xffb774bd)),
            child: Text(
              ok,
              style: TextStyle(color: Colors.red.shade800),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
