import 'package:flutter/material.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class RatingItem extends StatelessWidget {

const RatingItem({Key key, this.mainAxisAlignment}) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        "4,3".description(context, color: Theme.of(context).iconTheme.color),
        SpacerBox.h5,
        Icon(
          Icons.star,
          size: 10,
        ),
        SpacerBox.h5,
        "(1.568)"
            .description(context, color: Theme.of(context).iconTheme.color),
      ],
    );
  }
}