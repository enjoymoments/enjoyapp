import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class CustomTile extends StatelessWidget {
  final IconData iconStart;
  final IconData iconEnd;
  final String title;
  final String description;
  final Function onTap;

  const CustomTile({
    Key key,
    @required this.iconStart,
    @required this.iconEnd,
    @required this.title,
    @required this.description,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          CustomIcon(
            icon: iconStart,
          ),
          SpacerBox.h16,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.label(context),
                description.description(context),
              ],
            ),
          ),
          CustomIcon(
            icon: iconEnd,
          ),
        ],
      ),
    );
  }
}
