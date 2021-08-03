import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final double width;

  const CardContainer({
    Key key,
    @required this.child,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(8.0)),
        child: child,
      ),
    );
  }
}
