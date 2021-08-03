import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/spacer_box.dart';

class ActivityLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.sizeByPixel(50)),
              height: SizeConfig.sizeByPixel(20),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(100),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.sizeByPixel(50)),
              height: SizeConfig.sizeByPixel(20),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(100),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.sizeByPixel(50)),
              height: SizeConfig.sizeByPixel(20),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(100),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.sizeByPixel(50)),
              height: SizeConfig.sizeByPixel(20),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(100),
            ),
            SpacerBox.v16,
          ],
        ),
      ),
    );
  }
}
