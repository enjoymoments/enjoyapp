import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/spacer_box.dart';

class CategorieItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShimmerLoading(
            width: SizeConfig.sizeByPixel(130),
            height: SizeConfig.sizeByPixel(90),
          ),
          SpacerBox.h43,
          ShimmerLoading(
            width: SizeConfig.sizeByPixel(130),
            height: SizeConfig.sizeByPixel(90),
          ),
        ],
      ),
    );
  }
}
