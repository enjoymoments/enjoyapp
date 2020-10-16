import 'package:flutter/material.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/views/me/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/me/widgets/login/widgets/google_login_button.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_text_form_field.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Entre com o seu email e senha',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SpacerBox.v16,
          CustomTextFormField(
            textInputType: TextInputType.emailAddress,
            hintText: 'Informe o seu e-mail',
            labelText: 'E-mail',
            validate: (String value) {},
          ),
          SpacerBox.v16,
          CustomTextFormField(
            textInputType: TextInputType.visiblePassword,
            hintText: 'Informe senha',
            labelText: 'Senha',
            validate: (String value) {},
          ),
          SpacerBox.v16,
          GoogleLoginButton(
            authenticationBloc: getItInstance<AuthenticationBloc>(),
          ),
        ],
      ),
    );
  }
}
