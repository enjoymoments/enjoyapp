import 'package:flutter/material.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';

class CustomAvatarWithName extends StatelessWidget {
  final ImageProvider backgroundImage;
  final String name;
  final Widget child;

  const CustomAvatarWithName({Key key, @required this.name, this.child, this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAvatar(
          backgroundImage: backgroundImage,
        ),
        SpacerBox.h8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name.label(context),
            SpacerBox.v2,
            child ?? SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
