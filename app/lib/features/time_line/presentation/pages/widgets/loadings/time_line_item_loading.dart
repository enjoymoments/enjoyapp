import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/spacer_box.dart';

class TimeLineItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(100),
              height: SizeConfig.sizeByPixel(20),
            ),
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(100),
              height: SizeConfig.sizeByPixel(20),
            ),
          ],
        ),
        SpacerBox.v16,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
          height: SizeConfig.sizeByPixel(50),
        ),
        SpacerBox.v16,
        ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
          height: SizeConfig.sizeByPixel(150),
        ),
      ],
    );
  }
}
