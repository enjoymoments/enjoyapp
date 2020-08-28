import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/theme.dart';
import 'package:mozin/views/onboading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mozin',
      debugShowCheckedModeBanner: false,
      theme: getTheme(context),
      home: OnBoardingPage(),
    );
  }
}
