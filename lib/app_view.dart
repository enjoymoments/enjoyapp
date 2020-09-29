import 'package:flutter/material.dart';
import 'package:mozin/router.gr.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/theme.dart';
import 'package:mozin/views/me/widgets/login/bloc/authentication_bloc.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = getItInstance<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mozin',
      debugShowCheckedModeBanner: false,
      theme: getTheme(context),
      onGenerateRoute: Router(),
    );
  }
}
