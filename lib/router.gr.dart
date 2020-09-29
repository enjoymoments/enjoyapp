// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'views/intro/intro_screen.dart';
import 'views/onboading_screen.dart';
import 'views/screen_manager.dart';

class Routes {
  static const String intro_screen = '/';
  static const String screen_manager = '/screen-manager';
  static const String onboarding_screen = '/on-boarding-screen';
  static const all = <String>{
    intro_screen,
    screen_manager,
    onboarding_screen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.intro_screen, page: IntroScreen),
    RouteDef(Routes.screen_manager, page: ScreenManager),
    RouteDef(Routes.onboarding_screen, page: OnBoardingScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    IntroScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => IntroScreen(),
        settings: data,
      );
    },
    ScreenManager: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScreenManager(),
        settings: data,
      );
    },
    OnBoardingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingScreen(),
        settings: data,
      );
    },
  };
}
