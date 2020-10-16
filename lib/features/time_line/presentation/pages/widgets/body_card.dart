import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';

class BodyCard extends StatelessWidget {
  const BodyCard({Key key, @required this.item}) : super(key: key);

  final TimeLineItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            fit: BoxFit.fill,
            //TODO:review
            imageUrl: item.medias[0].url,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
    );
  }
}
