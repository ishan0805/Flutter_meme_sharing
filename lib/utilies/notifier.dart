import 'package:flutter/material.dart';

class Notifier {
  static showSnackbar(BuildContext context, String message) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static showDialog() {}
}
