import 'package:flutter/material.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';

 class CustomAppBar extends AppBar {
  CustomAppBar({
    Key key,
    @required BuildContext context,
    @required String title,
    @required void Function() onPressedBack,
    List<Widget> actions,
  }) : super(
            title: Text(title),
            leading: IconButton(
              icon: CustomIcon(icon: AppIcons.arrow_left, color: Theme.of(context).appBarTheme.iconTheme.color),
              onPressed: onPressedBack,
            ),
            actions: actions);
}
