import 'package:flutter/cupertino.dart';

class Keyboard {
  static dismiss(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
