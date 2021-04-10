import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class TimeLineAvatar extends StatelessWidget {
  final ImageProvider backgroundImage;
  final String name;

  const TimeLineAvatar({
    Key key,
    @required this.name,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAvatar(
          backgroundImage: backgroundImage,
        ),
        SpacerBox.v4,
        name.label(context),
      ],
    );
  }
}
