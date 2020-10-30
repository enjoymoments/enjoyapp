import 'package:flutter/material.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key key,
    @required String title,
    void Function() onPressedBack,
    List<Widget> actions,
  }) : super(
            title: Text(title),
            leading: IconButton(
              icon: CustomIcon(icon: AppIcons.arrow_left),
              onPressed: onPressedBack != null ? onPressedBack : null,
            ),
            actions: actions);
}
