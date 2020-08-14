import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/repositories/authentication_repository.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/custom_text_form_field.dart';
import 'package:mozin/views/shared/spacer_box.dart';

//TODO:in development

class LoginScreen extends StatefulWidget {
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
            _GoogleLoginButton(),
          ],
        ),
      ),
    );
  }
}

//TODO: in development
class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RaisedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      icon: const Icon(Icons.access_alarm, color: Colors.white),
      color: theme.accentColor,
      onPressed: () {
        AuthenticationRepository authenticationRepository = AuthenticationRepository();
        authenticationRepository.logInWithGoogle();
      },
    );
  }
}
