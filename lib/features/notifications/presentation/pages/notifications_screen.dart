import 'package:auto_route/auto_route.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';
class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(context),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody(BuildContext context) {
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

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Alertas',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () => ExtendedNavigator.of(context).pop(),
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
