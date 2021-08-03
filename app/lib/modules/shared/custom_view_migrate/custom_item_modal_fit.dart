import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomItemModalFit extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData iconData;

  const CustomItemModalFit({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Icon(iconData),
      onTap: () {
        ExtendedNavigator.of(context).pop();
        onTap();
      },
    );
  }
}
