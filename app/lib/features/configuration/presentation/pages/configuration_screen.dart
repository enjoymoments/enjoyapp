import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/custom_tile.dart';
import 'package:custom_view/spacer_box.dart';

class ConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildContent(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Configurações',
      context: context,
      onPressedBack: () => ExtendedNavigator.of(context).pop(),
    );
  }

  Widget _buildContent() {
    return CustomContainer(
      child: Column(
        children: [
          CustomTile(
            iconStart: AppIcons.calendar_day,
            iconEnd: AppIcons.angle_right,
            title: "Data",
            description: 'bla bla bla',
            onTap: () {},
          ),
          SpacerBox.v16,
          CustomDivider(),
          SpacerBox.v16,
          CustomTile(
            iconStart: AppIcons.calendar_day,
            iconEnd: AppIcons.angle_right,
            title: "Data",
            description: 'bla bla bla',
            onTap: () {},
          ),
          SpacerBox.v16,
        ],
      ),
    );
  }
}
