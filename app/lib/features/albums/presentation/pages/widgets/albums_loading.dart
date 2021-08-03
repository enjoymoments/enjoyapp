import 'package:flutter/material.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/spacer_box.dart';

class AlbumsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomContainer(
      child: ListView.separated(
        separatorBuilder: (context, index) => SpacerBox.v16,
        itemCount: 5,
        itemBuilder: (context, index) => ShimmerLoading(
          width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
          height: SizeConfig.sizeByPixel(150),
        ),
      ),
    );
  }
}
