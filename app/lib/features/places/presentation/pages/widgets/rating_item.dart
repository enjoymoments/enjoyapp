import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class RatingItem extends StatelessWidget {

const RatingItem({Key key, this.mainAxisAlignment, @required this.item}) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final PlaceModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        item.rating.toString().description(context),
        SpacerBox.h5,
        CustomIcon(icon: AppIcons.star, size: 10),
        SpacerBox.h5,
        "(${item.userRatingsTotal})"
            .description(context),
      ],
    );
  }
}