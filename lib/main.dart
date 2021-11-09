import 'package:crio_meme_sharing_app/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme Sharing',
      theme: ThemeData(
          brightness: Brightness.dark,
          //primaryColor: Colors.white,
          // hoverColor: Colors.white,
          //focusColor: Colors.white,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Color(0xFF2ba399))),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF2ba399),
            textTheme: ButtonTextTheme.primary,
          ),
          //primarySwatch: MaterialColor(500,{''}),
          primaryColorBrightness: Brightness.dark),
      initialRoute: (Hive.box('user').get('token') == null) ? '/' : '/feeds',
      onGenerateRoute: RouteGenerator.generateRoute, // Home()
    );
  }
}
