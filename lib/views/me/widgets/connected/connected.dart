import 'package:flutter/material.dart';
import 'package:mozin/views/me/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/shared/custom_container.dart';

class Connected extends StatelessWidget {

  final AuthenticationBloc authenticationBloc;

  const Connected({Key key, @required this.authenticationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: InkWell(
        onTap: () {
          print('tocou');
          authenticationBloc.add(Logout());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Toque para sair',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}