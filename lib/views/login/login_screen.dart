import 'package:flutter/material.dart';
import 'package:mozin/views/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/login/widgets/google_login_button.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/custom_text_form_field.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class LoginScreen extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;

  const LoginScreen({
    Key key,
    @required this.authenticationBloc,
  }) : super(key: key);
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return CustomScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      bottomNavigationBar: null,
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            SpacerBox.v16,
            Text(
              'Entre com o seu email e senha',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            SpacerBox.v34,
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
              authenticationBloc: widget.authenticationBloc,
            ),
          ],
        ),
      ),
    );
  }
}
