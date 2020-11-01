import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/shimmerLoading.dart';
import 'package:mozin/package_view/spacer_box.dart';

class PlaceCardItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(100),
          height: SizeConfig.sizeByPixel(20),
        ),
        SpacerBox.v8,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(100),
          height: SizeConfig.sizeByPixel(20),
        ),
        SpacerBox.v8,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(100),
          height: SizeConfig.sizeByPixel(20),
        ),
        SpacerBox.v8,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(100),
          height: SizeConfig.sizeByPixel(20),
        ),
      ],
    );
  }
}
