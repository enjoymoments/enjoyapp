import 'package:flutter/material.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/views/shared/spacer_box.dart';
import 'package:mozin/views/time_line/components/body_card.dart';
import 'package:mozin/views/time_line/components/footer_card.dart';
import 'package:mozin/views/time_line/components/header_card.dart';

class TimeLineItem extends StatelessWidget {
  const TimeLineItem({Key key, @required this.item}) : super(key: key);

  final TimeLineItemModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpacerBox.v4,
        HeaderCard(),
        SpacerBox.v8,
        BodyCard(item: item),
        FooterCard(),
        SpacerBox.v4,
      ],
    );
  }
}
