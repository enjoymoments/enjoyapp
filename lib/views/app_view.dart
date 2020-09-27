import 'package:flutter/material.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/screen_manager.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return ScreenManager(
      authenticationBloc: getItInstance<AuthenticationBloc>(),
    );
  }
}
