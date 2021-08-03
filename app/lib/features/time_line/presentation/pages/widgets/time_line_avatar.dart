import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class TimeLineAvatar extends StatelessWidget {
  final ImageProvider backgroundImage;
  final String name;
  final bool selected;

  const TimeLineAvatar({
    Key key,
    @required this.name,
    this.backgroundImage,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAvatar(
          backgroundImage: backgroundImage,
        ),
        SpacerBox.v4,
        _buildLabel(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    if(selected) {
      return name.label(context, color: Theme.of(context).primaryColor);
    }

    return name.label(context);
  }
}
