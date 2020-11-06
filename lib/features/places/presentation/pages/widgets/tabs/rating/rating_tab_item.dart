import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/rating/percentage_widget.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/rating/user_comment_widget.dart';
import 'package:mozin/package_view/spacer_box.dart';

class RatingTabItem extends StatelessWidget {
  final PlaceModel item;

  const RatingTabItem({Key key, @required this.item}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacerBox.v8,
        PercentageWidget(),
        SpacerBox.v16,
        UserCommentWidget(item: item,),
        SpacerBox.v8,
        UserCommentWidget(item: item,),
        SpacerBox.v8,
        UserCommentWidget(item: item,),
      ],
    );
  }
}