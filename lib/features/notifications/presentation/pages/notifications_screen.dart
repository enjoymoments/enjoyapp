import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/extension.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildAnimation(),
          "Ops... ainda não está pronto.".labelIntro(context),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return Container(
      height: 250,
      child: FlareActor("assets/animations/watermelon.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "falling seed"),
    );
  }
}
