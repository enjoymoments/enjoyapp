import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BodyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/dart_side.png',
            fit: BoxFit.fill,
          ),
          // CachedNetworkImage(
          //   fit: BoxFit.fill,
          //   imageUrl:
          //       'https://blog.codemagic.io/uploads/2019/03/CM_Dart-vs-Javascript_FB.png',
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
    );
  }
}
