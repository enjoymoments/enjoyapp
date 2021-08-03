import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mozin/package_view/extension.dart';

class PercentageWidget extends StatelessWidget {
  final PlaceModel item;

  const PercentageWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLines(context),
        _buildRating(context),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.sizeByPixel(10)),
      child: Column(
        children: [
          item.rating.toString().description(context, fontSize: 48),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
              ),
              SpacerBox.h5,
              "(${item.userRatingsTotal})".description(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLines(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.sizeByPixel(5)),
          child: "RESUMO DAS AVALIAÇÕES".label(context),
        ),
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
