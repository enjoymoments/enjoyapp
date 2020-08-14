import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/login/login_screen.dart';
import 'package:mozin/views/screen_manager.dart';
import 'package:mozin/views/shared/bloc/default_state.dart';
import 'package:mozin/views/shared/custom_circular_progress_indicador.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';

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
    return CustomScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      bottomNavigationBar: null,
      child: BlocListener<AuthenticationBloc, DefaultState>(
        cubit: _authenticationBloc,
        listener: (context, state) {
          if (state is Loading) {
            return CustomCircularProgressIndicator();
          }

          if (state is AuthenticationSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => ScreenManager()),
              (route) => false,
            );
            return ScreenManager();
          }

          if (state is LogoutSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => LoginScreen(
                        authenticationBloc: _authenticationBloc,
                      )),
              (route) => false,
            );
            return ScreenManager();
          }

          return CustomCircularProgressIndicator();
        },
        child: LoginScreen(
          authenticationBloc: _authenticationBloc,
        ),
      ),
    );
  }
}
