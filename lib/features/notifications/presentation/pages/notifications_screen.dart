import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ListView.separated(
        separatorBuilder: (context, index) => _buildSeparator(),
        itemCount: 5,
        itemBuilder: (context, index) => _buildNotificationItem(context),
      ),
    );
  }

  Widget _buildSeparator() {
    return Column(
      children: [
        SpacerBox.v16,
        CustomDivider(),
        SpacerBox.v16,
      ],
    );
  }

  Widget _buildNotificationItem(BuildContext context) {
    return InkWell(
      onTap: () {
        print('tapped');
      },
      child: Row(
        children: [
          CustomAvatar(),
          SpacerBox.h16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Joice adicionou uma nova foto'.title(context),
              '2 minutos atrás'.description(context),
            ],
          ),
        ],
      ),
    );
  }
}
