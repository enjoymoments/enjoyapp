import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/me/widgets/connected/connected.dart';
import 'package:mozin/views/me/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/me/widgets/login/login_screen.dart';
import 'package:mozin/views/shared/blocs/default_state.dart';
import 'package:mozin/views/shared/blocs/screen_manager/screen_manager_bloc.dart';
import 'package:mozin/views/shared/custom_circular_progress_indicador.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';
import 'package:mozin/views/shared/extension.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = getItInstance<AuthenticationBloc>()
      ..add(CheckAuthenticated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, DefaultState>(
      cubit: _authenticationBloc,
      listener: (BuildContext context, DefaultState state) {
        if (state is Error) {
          context.showSnackBar('message');
        }

        if (state is LogoutSuccess) {
          getItInstance<ScreenManagerBloc>()
            ..add(TapScreen(DEFAULT_MENU_ENUM.ME));
        }
      },
      builder: (BuildContext context, DefaultState state) {
        if (state is Loading) {
          return CustomCircularProgressIndicator();
        }

        if (state is AuthenticationSuccess) {
          return Connected(
            authenticationBloc: _authenticationBloc,
          );
        }

        return SingleChildScrollView(
          child: LoginScreen(),
        );
      },
    );
  }
}
