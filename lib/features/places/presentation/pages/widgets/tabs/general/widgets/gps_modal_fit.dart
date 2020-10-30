import 'package:flutter/material.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';

class GpsModalFit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: "Waze".label(context),
              leading: CustomIcon(
                icon: AppIcons.waze,
              ),
              onTap: () {},
            ),
            ListTile(
              title: 'Google Maps'.label(context),
              leading: CustomIcon(
                icon: AppIcons.map_signs,
              ),
              onTap: () {},
            ),
            ListTile(
              title: 'Apple Maps'.label(context),
              leading: CustomIcon(
                icon: AppIcons.apple,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
