import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/login/bloc/login_bloc.dart';
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
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = getItInstance<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      bottomNavigationBar: null,
      child: BlocListener<LoginBloc, DefaultState>(
        cubit: _loginBloc,
        listener: (context, state) {
          if (state is Loading) {
            return CustomCircularProgressIndicator();
          }

          if (state is LoginSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => ScreenManager()),
              (route) => false,
            );
            return ScreenManager();
          }

          return CustomCircularProgressIndicator();
        },
        child: LoginScreen(
          loginBloc: _loginBloc,
        ),
      ),
    );
  }
}
