import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/shimmerLoading.dart';
import 'package:mozin/package_view/spacer_box.dart';

class PlaceCardItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
          height: SizeConfig.sizeByPixel(120),
        );
      },
      separatorBuilder: (context, index) => SpacerBox.v16,
    );
  }
}
