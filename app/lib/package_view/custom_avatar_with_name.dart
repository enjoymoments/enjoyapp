import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

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
