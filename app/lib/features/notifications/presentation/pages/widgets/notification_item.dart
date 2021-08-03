import 'package:flutter/material.dart';
import 'package:mozin/features/notifications/data/models/notifications_model.dart';
import 'package:custom_view/extensions/extension.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key key, @required this.item}) : super(key: key);

  final NotificationsModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        item.message.title(context),
        item.dateCreationFormatted.description(context),
      ],
    );
  }
}
