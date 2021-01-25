import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mozin/app_view.dart';
import 'package:mozin/modules/config/crashlytics.dart';
import 'package:mozin/modules/config/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();

  // This captures errors reported by the Flutter framework. (exceptions that occur when calling native code)
  reportErrorsPlatform();

  runZonedGuarded<Future<void>>(() async {
    initializeDateFormatting().then((_) => runApp(AppView()));
  }, (Object error, StackTrace stackTrace) {
    reportError(error, stackTrace);
  });
}
