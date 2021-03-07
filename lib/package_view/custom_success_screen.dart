import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class CustomSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildContent(context),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Sucesso',
      onPressedBack: () {
        Navigator.of(context).pop();
      },
      actions: <Widget>[],
      context: context,
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAnimation(),
          "Muito obrigado pelo feedback !!!".labelIntro(context),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return Container(
      height: 200,
      child: FlareActor("assets/animations/success.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "Untitled"),
    );
  }
}
