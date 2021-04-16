import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mozin/app_view.dart';
import 'package:mozin/modules/config/crashlytics.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/firebase/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await setup();
  setupRoot();

  // This captures errors reported by the Flutter framework. (exceptions that occur when calling native code)
  reportErrorsPlatform();

  //TODO:share review this
  ConfigureFirebaseDynamicLinks _configureDynamicLinks = ConfigureFirebaseDynamicLinks();
  _configureDynamicLinks.initDynamicLinks();

  runZonedGuarded<Future<void>>(() async {
    initializeDateFormatting().then((_) => runApp(AppView()));
  }, (Object error, StackTrace stackTrace) {
    reportError(error, stackTrace);
  });
}
