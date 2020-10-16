import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mozin/app_view.dart';
import 'package:mozin/modules/config/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();
  runApp(AppView());
}
