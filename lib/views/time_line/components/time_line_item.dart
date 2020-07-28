import 'package:flutter/material.dart';
import 'package:mozin/views/shared/spacer_box.dart';
import 'package:mozin/views/time_line/components/body_card.dart';
import 'package:mozin/views/time_line/components/footer_card.dart';
import 'package:mozin/views/time_line/components/header_card.dart';

class TimeLineItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpacerBox.v4,
        HeaderCard(),
        SpacerBox.v8,
        BodyCard(),
        FooterCard(),
        SpacerBox.v4,
      ],
    );
  }
}
