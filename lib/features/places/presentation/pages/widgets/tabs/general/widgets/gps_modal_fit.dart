import 'package:flutter/material.dart';
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
              leading: Icon(Icons.card_travel),
              onTap: () {},
            ),
            ListTile(
              title: 'Google Maps'.label(context),
              leading: Icon(Icons.map),
              onTap: () {},
            ),
            ListTile(
              title: 'Apple Maps'.label(context),
              leading: Icon(Icons.delete),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
