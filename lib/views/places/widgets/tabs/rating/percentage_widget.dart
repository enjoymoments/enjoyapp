import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/views/shared/spacer_box.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mozin/views/shared/extension.dart';

class PercentageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Row(
      children: [
        _buildLines(context),
        _buildRating(context),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    return Column(
      children: [
        "4.3".description(context, fontSize: 48),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 10,
            ),
            SpacerBox.h5,
            "(1.568)".description(context),
          ],
        ),
      ],
    );
  }

  Widget _buildLines(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "RESUMO DAS AVALIAÇÕES".label(context),
        SpacerBox.v8,
        LinearPercentIndicator(
          width: SizeConfig.sizeByPixel(200),
          lineHeight: 8.0,
          percent: 0.40,
          progressColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).hintColor,
        ),
        SpacerBox.v8,
        LinearPercentIndicator(
          width: SizeConfig.sizeByPixel(200),
          lineHeight: 8.0,
          percent: 0.20,
          progressColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).hintColor,
        ),
        SpacerBox.v8,
        LinearPercentIndicator(
          width: SizeConfig.sizeByPixel(200),
          lineHeight: 8.0,
          percent: 0.50,
          progressColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).hintColor,
        ),
        SpacerBox.v8,
        LinearPercentIndicator(
          width: SizeConfig.sizeByPixel(200),
          lineHeight: 8.0,
          percent: 0.70,
          progressColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).hintColor,
        ),
        SpacerBox.v8,
        LinearPercentIndicator(
          width: SizeConfig.sizeByPixel(200),
          lineHeight: 8.0,
          percent: 0.10,
          progressColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).hintColor,
        ),
      ],
    );
  }
}
