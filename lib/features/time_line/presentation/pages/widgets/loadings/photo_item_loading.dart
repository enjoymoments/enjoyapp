import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/shimmerLoading.dart';

class PhotoItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomContainer(
      child: ShimmerLoading(
        width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
        height: SizeConfig.sizeByPixel(150),
      ),
    );
  }
}