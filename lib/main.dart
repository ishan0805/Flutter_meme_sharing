import 'package:crio_meme_sharing_app/screens/create_meme.dart';
import 'package:crio_meme_sharing_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/meme_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<MemeBloc>(
      create: (_) => MemeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meme Sharing',
        theme: ThemeData.dark().copyWith(
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (state) => Colors.white)))),
        home: //CreateMeme(),
            MyHomePage(title: 'Meme Sharing'),
      ),
    );
  }
}
