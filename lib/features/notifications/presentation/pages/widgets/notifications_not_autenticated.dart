import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mozin/package_view/extension.dart';

class NotificationsNotAutenticated extends StatelessWidget {
  const NotificationsNotAutenticated({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAnimation(),
        "Eita... sem o login, não conseguimos trazer nada por aqui"
            .labelIntro(context),
      ],
    );
  }

  Widget _buildAnimation() {
    return Container(
      height: 200,
      child: FlareActor(
        "assets/animations/watermelon.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "falling seed",
      ),
    );
  }
}