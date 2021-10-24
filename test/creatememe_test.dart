import 'package:crio_meme_sharing_app/bloc/meme_bloc.dart';
import 'package:crio_meme_sharing_app/screens/create_meme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_test/flutter_test.dart';

Widget CreateMemeScreen() => ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meme Sharing',
        theme: ThemeData.dark(),
        home: CreateMeme(), // Home()
      ),
    );

void main() {
  /*final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();*/
  group("CreateMemeScreen", () {
    testWidgets('CreateMemeScreen showed up ', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(CreateMemeScreen());
      await tester.pumpAndSettle();
      // Verify that CreateMeme Screen is launching
      expect(find.byType(Scaffold), findsOneWidget);
    });
    testWidgets("Testing overflow of CreateMemeScreen page  in a mobile screen",
        (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(700, 1000);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(CreateMemeScreen());

      // Verify that CreateMemeScreen  is launching
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets("Testing overflow of CreateMemeScreen page in a tablet screen",
        (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      // Build our app and trigger a frame.
      await tester.pumpWidget(CreateMemeScreen());

      // Verify that GstSearch Screen is launching
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets(
        "Testing if CreateMemeScreen shows up validations on empty submission",
        (tester) async {
      await tester.pumpWidget(CreateMemeScreen());
      final Finder formWidgetFinder = find.byType(Form);
      final Form formWidget = tester.widget(formWidgetFinder) as Form;
      final GlobalKey<FormState> formKey =
          formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), isFalse);
    });
    testWidgets(
        "Testing if CreateMemeScreen shows up validations on submission on fields with data",
        (tester) async {
      await tester.pumpWidget(CreateMemeScreen());
      final Finder name = find.byKey(ValueKey('name'));
      await tester.enterText(name, "ishan");
      final Finder url = find.byKey(ValueKey('url'));
      await tester.enterText(url, "ishan");
      final Finder caption = find.byKey(ValueKey('caption'));
      await tester.enterText(caption, "ishan");

      await tester.pump();
      final Finder formWidgetFinder = find.byType(Form);
      final Form formWidget = tester.widget(formWidgetFinder) as Form;
      final GlobalKey<FormState> formKey =
          formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), isTrue);
    });
  });
}
