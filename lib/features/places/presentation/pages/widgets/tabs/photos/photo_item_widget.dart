import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';

class PhotoItemWidget extends StatelessWidget {
  final Uint8List item;

  const PhotoItemWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: SizeConfig.sizeByPixel(100),
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.memory(item, fit: BoxFit.cover, width: SizeConfig.sizeByPixel(150)),
            ],
          ),
        ),
      ),
    );
  }
}
