import 'package:flutter/material.dart';
import 'package:mozin/views/shared/extension.dart';

class HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            "12/12/2019".date(context),
            IconButton(
              icon: new Icon(Icons.more_horiz),
              iconSize: Theme.of(context).iconTheme.size,
              onPressed: () {},
            ),
          ],
        ),
        "Foi maravilhosa a viajem que fizemos, amei estar com você vivendo essa experiência."
            .description(context),
      ],
    );
  }
}
