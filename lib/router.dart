import 'package:auto_route/auto_route_annotations.dart';
import 'package:mozin/views/intro/intro_screen.dart';
import 'package:mozin/views/onboading_screen.dart';
import 'package:mozin/views/screen_manager.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(name: 'intro_screen', page: IntroScreen, initial: true),
    MaterialRoute(name: 'screen_manager', page: ScreenManager,),
    MaterialRoute(name: 'onboarding_screen', page: OnBoardingScreen,),
    
  ],
)
class $Router {}