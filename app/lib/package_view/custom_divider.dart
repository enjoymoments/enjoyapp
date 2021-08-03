import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).hintColor,
      height: SizeConfig.sizeByPixel(4),
    );
  }
}
