import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class FeatureCard extends StatelessWidget {
  final IconData iconData;
  final String routeName;
  final String name;
  final double width;
  final bool disabled;

  const FeatureCard({
    Key key,
    @required this.iconData,
    @required this.routeName,
    @required this.name,
    this.width,
    this.disabled = false,
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
                color: disabled ? Theme.of(context).disabledColor : null,
              ),
              SpacerBox.v8,
              name.description(
                context,
                color: disabled ? Theme.of(context).disabledColor : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
