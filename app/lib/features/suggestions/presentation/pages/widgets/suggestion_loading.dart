import 'package:flutter/material.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:custom_view/spacer_box.dart';

class SuggestionLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ListView.separated(
      separatorBuilder: (context, index) => SpacerBox.v16,
      itemCount: 15,
      itemBuilder: (context, index) => ShimmerLoading(
        width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
        height: SizeConfig.sizeByPixel(60),
      ),
    );
  }
}
