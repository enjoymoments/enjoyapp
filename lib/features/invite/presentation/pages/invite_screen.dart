import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class InviteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Center(child: 'Test'.title(context),),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Convidar',
      context: context,
      onPressedBack: () {
        Navigator.of(context).pop();
      },
      actions: <Widget>[
      ],
    );
  }
}
