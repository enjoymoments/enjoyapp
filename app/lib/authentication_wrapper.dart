import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_wrapper_screen.dart';
import 'package:mozin/features/screen_manager/presentation/root_screen_manager.dart';
import 'package:mozin/modules/config/setup.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      cubit: root<AuthenticationBloc>(),
      buildWhen: (previous, current) {
        return previous.authenticated != current.authenticated;
      },
      builder: (context, state) {
        if(state.authenticated) {
          return RootScreenManager();
        }

        return LoginWrapperScreen();
      },
    );
  }
}