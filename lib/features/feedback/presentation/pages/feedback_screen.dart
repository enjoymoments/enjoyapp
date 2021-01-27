import 'package:flutter/material.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_tile.dart';
import 'package:mozin/package_view/spacer_box.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Ajude-nos a melhorar o app',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: Column(
        children: [
          CustomTile(
            title: 'Quero relatar um problema',
            description: 'bla bla bla',
            iconStart: AppIcons.bug,
            iconEnd: AppIcons.angle_right,
            onTap: () {},
          ),
          SpacerBox.v16,
          CustomTile(
            title: 'Tenho uma sugestão ou elogio',
            description: 'bla bla bla',
            iconStart: AppIcons.star,
            iconEnd: AppIcons.angle_right,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
