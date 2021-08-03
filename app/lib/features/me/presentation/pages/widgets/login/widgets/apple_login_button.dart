import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:custom_view/AppIcons.dart';

class AppleLoginButton extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const AppleLoginButton({Key key, @required this.authenticationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.sizeByPixel(50.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: theme.primaryColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: IconButton(
        icon: Icon(AppIcons.apple, color: theme.primaryColor),
        onPressed: () {
          authenticationBloc.add(RequestAppleLogin());
        },
      ),
    );
  }
}
