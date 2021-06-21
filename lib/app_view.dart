import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart' as rt;
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/theme.dart';
import 'package:mozin/modules/shared/firebase/analytics_service.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = root<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mozin',
      debugShowCheckedModeBanner: false,
      theme: getTheme(context),
      onGenerateRoute: (settings) => rt.Router().onGenerateRoute(settings),
      builder: ExtendedNavigator.builder(
        router: rt.Router(),
        builder: (context, extendedNav) {
          return extendedNav;
        },
      ),
      navigatorObservers: <NavigatorObserver>[
        getItInstance<AnalyticsService>().getAnalyticsObserver(),
      ],
    );
  }
}
