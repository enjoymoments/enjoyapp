import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_screen.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/enum/default_menu_enum.dart';
import 'package:mozin/package_view/extension.dart';

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
