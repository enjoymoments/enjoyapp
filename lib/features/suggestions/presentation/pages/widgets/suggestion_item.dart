import 'package:flutter/material.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'item.message'.title(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            'item.dateCreationFormatted'.description(context),
            Row(
              children: [
                _buildLike(context),
                SpacerBox.h43,
                _buildDislike(context),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLike(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CustomIcon(icon: AppIcons.thumbs_up),
          SpacerBox.h5,
          "12".label(context),
        ],
      ),
    );
  }

    Widget _buildDislike(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CustomIcon(icon: AppIcons.thumbs_down),
          SpacerBox.h5,
          "12".label(context),
        ],
      ),
    );
  }
}
