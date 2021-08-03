import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';

class CustomModalFit extends StatelessWidget {
  final List<CustomItemModalFit> items;

  const CustomModalFit({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }
}
