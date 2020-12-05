import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/review_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_border.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class UserCommentWidget extends StatelessWidget {
  final ReviewModel review;

  const UserCommentWidget({Key key, @required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      margin: EdgeInsets.only(bottom: 8),
      child: CustomContainer(
        customMargin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CustomAvatar(
                  backgroundImage: NetworkImage(review.profilePhotoUrl),
                ),
                SpacerBox.h8,
                review.authorName.description(context),
              ],
            ),
            SpacerBox.v4,
            Row(
              children: [
                review.rating.toString().description(context),
                SpacerBox.h5,
                CustomIcon(icon: AppIcons.star, size: 10,),
                SpacerBox.h8,
                review.relativeTimeDescription
                    .description(context, fontSize: 10),
              ],
            ),
            SpacerBox.v4,
            review.text.label(
              context,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
