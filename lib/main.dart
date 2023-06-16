// ignore_for_file: prefer_const_constructors

import 'package:cheongrahm/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(App());
}

class OffScrollGlowBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: OffScrollGlowBehavior(),
      home: Splash(),
      theme: ThemeData(fontFamily: 'Pretendard'),
    );
  }
}
