import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/review_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/rating/percentage_widget.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/rating/user_comment_widget.dart';
import 'package:custom_view/spacer_box.dart';

class RatingTabItem extends StatelessWidget {
  final PlaceModel? item;

  const RatingTabItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacerBox.v8,
        PercentageWidget(
          item: item,
        ),
        SpacerBox.v16,
        ...item!.reviews!.map((e) {
          return UserCommentWidget(
            review: e as ReviewModel,
          );
        }).toList()
      ],
    );
  }
}