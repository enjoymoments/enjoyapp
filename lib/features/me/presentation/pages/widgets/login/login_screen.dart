import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/facebook_login_button.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/google_login_button.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          'Não quer entrar para tomar uma xícara de café?'.labelIntro(context),
          SpacerBox.v16,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoogleLoginButton(
                authenticationBloc: root<AuthenticationBloc>(),
              ),
              SpacerBox.h16,
              FacebookLoginButton(
                authenticationBloc: root<AuthenticationBloc>(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
