import 'package:flutter/material.dart';

class PhotoItemWidget extends StatelessWidget {
  final String item;

  const PhotoItemWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 150.0),
            ],
          ),
        ),
      ),
    );
  }
}
