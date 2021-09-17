import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AnalyticsService {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();

  NavigatorObserver getAnalyticsObserver() =>
      _MyObserver(analytics: _firebaseAnalytics);

  //TODO:null-safety
  // FirebaseAnalyticsObserver getAnalyticsObserver() =>
  //     FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
}

class _MyObserver extends AutoRouterObserver {
  _MyObserver({
    required this.analytics,
    Function(PlatformException error)? onError,
  }) : _onError = onError;

  final FirebaseAnalytics analytics;
  final void Function(PlatformException error)? _onError;

  void _sendScreenView(String? screenName) {
    if (screenName != null) {
      analytics.setCurrentScreen(screenName: screenName).catchError(
        (Object error) {
          final _onError = this._onError;
          if (_onError == null) {
            debugPrint('$FirebaseAnalyticsObserver: $error');
          } else {
            _onError(error as PlatformException);
          }
        },
        test: (Object error) => error is PlatformException,
      );
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route.settings.name);
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    super.didInitTabRoute(route, previousRoute);
    _sendScreenView(route.name);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    super.didChangeTabRoute(route, previousRoute);
    _sendScreenView(route.name);
  }
}
