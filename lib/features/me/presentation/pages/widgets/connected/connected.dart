import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';

class Connected extends StatelessWidget {

  final AuthenticationBloc authenticationBloc;

  const Connected({Key key, @required this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: InkWell(
        onTap: () {
          authenticationBloc.add(Logout());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            'Toque para sair'.labelIntro(context),
          ],
        ),
      ),
    );
  }
}