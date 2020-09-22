import 'package:flutter/material.dart';

class CustomBorder extends StatelessWidget {
  final Widget child;
  final double height;

  const CustomBorder({Key key, @required this.child, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).iconTheme.color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
