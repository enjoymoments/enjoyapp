import 'package:custom_utilities/custom_utilities.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

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
      FirebaseCrashlytics.instance.recordFlutterError(details);
      _recordLogging(details.toString(), details.stack?.toString());
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

  FirebaseCrashlytics.instance.recordError(
    error,
    stackTrace,
  );

  _recordLogging(error.toString(), stackTrace?.toString());
}

void _recordLogging(String error, String? stackTrace) {
  try {
    final LoggerService _logger = getItInstance<LoggerService>();

    _logger.addLogAsync(
      LoggerModel(
        typeError: LoggerTypeEnum.Crashlytic,
        // ignore: always_specify_types
        error: {
          'body': error,
        },
        message: 'crashlytics',
        // ignore: always_specify_types
        extraInfo: {
          'command': stackTrace,
        },
      ),
      getItInstance.get<UserWrapper>().getUser?.email,
    );
  } catch (e) {
    print('error in set logger crashlytics');
  }
}
