import 'package:auto_route/auto_route_annotations.dart';
import 'package:mozin/views/intro/intro_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: IntroScreen, initial: true),
  ],
)
class $Router {}