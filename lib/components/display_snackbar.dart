import 'package:flutter/material.dart';

import 'custom_snackbar_content.dart';

ScaffoldMessengerState displaySnackBar(
  BuildContext context, {
  required String messageDescription,
  Color? cardBgColor,
  String? messageTitle,
  String? iconName,
}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: CustomSnackbarContent(
          messageDescription: messageDescription,
          cardBgColor: cardBgColor,
          messageTitle: messageTitle,
          iconName: iconName,
        ),
      ),
    );
}
