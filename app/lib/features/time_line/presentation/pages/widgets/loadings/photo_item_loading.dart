import 'package:flutter/material.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/shimmer_loading.dart';

class PhotoItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomContainer(
      child: ShimmerLoading(
        width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
        height: SizeConfig.sizeByPixel(150),
      ),
    );
  }
}
