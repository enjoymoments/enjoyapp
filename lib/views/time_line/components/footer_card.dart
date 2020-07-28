import 'package:flutter/material.dart';

class FooterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.message),
          iconSize: Theme.of(context).iconTheme.size,
          onPressed: () {},
        ),
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(Icons.share),
          iconSize: Theme.of(context).iconTheme.size,
          onPressed: () {},
        ),
      ],
    );
  }
}
