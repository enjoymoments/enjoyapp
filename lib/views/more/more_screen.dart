import 'package:flutter/material.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/me/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/shared/custom_container.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = getItInstance<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: InkWell(
        onTap: () {
          print('tocou');
          _authenticationBloc.add(Logout());
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
