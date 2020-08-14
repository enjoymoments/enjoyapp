import 'package:flutter/material.dart';
import 'package:mozin/views/login/bloc/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget {

  final LoginBloc loginBloc;

  const GoogleLoginButton({Key key, @required this.loginBloc}) : super(key: key);

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
         loginBloc.add(RequestGoogleLogin());
      },
    );
  }
}