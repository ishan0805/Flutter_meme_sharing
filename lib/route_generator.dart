import 'package:crio_meme_sharing_app/screens/feeds_page.dart';
import 'package:crio_meme_sharing_app/screens/home.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/feeds':
        return MaterialPageRoute(
            builder: (_) => FeedsPage(title: 'Meme Sharing'));
      default:
        MaterialPageRoute(builder: (_) => Error());
    }
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "SomeThing Went Wrong , Maybe developer was running low on coffee "),
      ),
    );
  }
}
