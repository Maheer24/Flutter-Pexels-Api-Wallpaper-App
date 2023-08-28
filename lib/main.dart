import 'package:flutter/material.dart';
import 'package:pixel/Pages/home_1_page.dart';
import 'package:pixel/Pages/splash_screen.dart';

import 'Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pixel",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: SplashScreen(),
    );
  }
}