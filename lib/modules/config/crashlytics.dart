import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/is_debug_mode.dart';

void reportErrorsPlatform() {
  // This captures errors reported by the Flutter framework.
  // exceptions that occur when calling native code
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Crashlytics.instance.recordFlutterError(details);
    }
  };
}

/// Reports [error] along with its [stackTrace] to Firebase Crashlitycs.
Future<void> reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  if (isInDebugMode) {
    debugPrint(stackTrace.toString());
    debugPrint('In dev mode. Not sending report to Firebase Crashlytics');
    return;
  }

  debugPrint('Reporting to Crashlitycs...');

  Crashlytics.instance.recordError(
    error,
    stackTrace,
  );
}
