import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class CardContent extends StatelessWidget {
  final IconData iconData;
  final String name;
  final String description;

  const CardContent({
    Key key,
    @required this.iconData,
    @required this.name,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIcon(
              icon: iconData,
            ),
            SpacerBox.h8,
            name.title(
              context,
            ),
          ],
        ),
        ..._buildDescription(context),
      ],
    );
  }

  List<Widget> _buildDescription(BuildContext context) {
    if (description != null) {
      return [
        SpacerBox.v8,
        description.description(context, maxLines: 3),
      ];
    }

    return null;
  }
}
