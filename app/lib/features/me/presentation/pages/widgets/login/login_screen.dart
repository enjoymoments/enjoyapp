import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/apple_login_button.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/facebook_login_button.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/widgets/google_login_button.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          'Encontre e registre suas melhores experiências'.labelIntro(context),
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
              ..._buildAppleSigning(),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppleSigning() {
    if (Platform.isIOS) {
      return [
        SpacerBox.h16,
        AppleLoginButton(
          authenticationBloc: root<AuthenticationBloc>(),
        ),
      ];
    }
    return [];
  }
}
