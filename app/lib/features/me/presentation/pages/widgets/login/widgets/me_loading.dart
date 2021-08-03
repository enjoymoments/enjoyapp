import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/shimmerLoading.dart';
import 'package:mozin/package_view/spacer_box.dart';

class MeLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: [
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(100),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(30),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(150),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(150),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(150),
            ),
          ],
        ),
      ),
    );
  }
}
