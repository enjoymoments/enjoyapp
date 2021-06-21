import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/shimmerLoading.dart';
import 'package:mozin/package_view/spacer_box.dart';

class UnsyncCoupleScreenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildContent(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Convite',
      context: context,
      onPressedBack: () {
        ExtendedNavigator.of(context).pop();
      },
      actions: <Widget>[],
    );
  }

  Widget _buildContent() {
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
              height: SizeConfig.sizeByPixel(80),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(80),
            ),
            SpacerBox.v16,
            ShimmerLoading(
              width: SizeConfig.sizeByPixel(SizeConfig.screenWidth),
              height: SizeConfig.sizeByPixel(80),
            ),
          ],
        ),
      ),
    );
  }
}
