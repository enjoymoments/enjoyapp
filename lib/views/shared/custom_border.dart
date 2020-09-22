import 'package:flutter/material.dart';
import 'package:mozin/size_config.dart';

class CustomBorder extends StatelessWidget {
  final Widget child;

  const CustomBorder({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: double.infinity,
      height: SizeConfig.sizeByPixel(34),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).iconTheme.color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
