import 'package:flutter/material.dart';
import 'package:custom_view/custom_container.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Mais',
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
