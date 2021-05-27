import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class FeatureCard extends StatelessWidget {
  final IconData iconData;
  final String routeName;
  final String name;
  final double width;

  const FeatureCard({
    Key key,
    @required this.iconData,
    @required this.routeName,
    @required this.name,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.sizeByPixel(10),
        bottom: SizeConfig.sizeByPixel(10),
      ),
      child: GestureDetector(
        onTap: () {
          ExtendedNavigator.of(context).push(routeName);
        },
        child: CardContainer(
          width: width,
          child: Column(
            children: [
              CustomIcon(
                icon: iconData,
              ),
              SpacerBox.v8,
              name.description(
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
