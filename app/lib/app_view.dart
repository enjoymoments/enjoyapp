import 'package:auto_route/auto_route.dart';
import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/firebase/analytics_service.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  AuthenticationBloc? _authenticationBloc;
  final _appRouter = AppRouter();

  @override
  void initState() {
    _authenticationBloc = root<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [
          getItInstance<AnalyticsService>().getAnalyticsObserver(),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Mozin',
      debugShowCheckedModeBanner: false,
      theme: getTheme(context, "Abel"),
    );
  }
}
