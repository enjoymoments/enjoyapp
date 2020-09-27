import 'package:flutter/material.dart';
import 'package:mozin/views/places/widgets/tabs/rating/percentage_widget.dart';
import 'package:mozin/views/places/widgets/tabs/rating/user_comment_widget.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class RatingTabItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacerBox.v8,
        PercentageWidget(),
        SpacerBox.v16,
        UserCommentWidget(),
        SpacerBox.v8,
        UserCommentWidget(),
        SpacerBox.v8,
        UserCommentWidget(),
      ],
    );
  }
}