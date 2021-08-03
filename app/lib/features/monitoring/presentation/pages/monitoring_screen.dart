import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/extensions/extension.dart';
class MonitoringScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAnimation(),
          "Ops... ainda não está pronto.".labelIntro(context),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return Container(
      height: 200,
      child: FlareActor("assets/animations/watermelon.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "falling seed"),
    );
  }
}
