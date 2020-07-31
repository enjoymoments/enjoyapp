import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/galley_images/models/gallery_image_model.dart';
import 'package:mozin/views/shared/custom_dialog.dart';
import 'package:vibration/vibration.dart';

class GalleryImageThumbnail extends StatelessWidget {
  const GalleryImageThumbnail({Key key, this.galleryImageModel, this.onTap})
      : super(key: key);

  final GalleryImageModel galleryImageModel;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () {
          _removeMedia(context);
        },
        child: Hero(
          tag: galleryImageModel.id,
          child: Container(
            height: 80,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                galleryImageModel.resource,
                fit: BoxFit.fill,
              ),
              // CachedNetworkImage(
              //   imageUrl: imageUrl,
              //   fit: BoxFit.fill,
              //   progressIndicatorBuilder: (context, url, downloadProgress) =>
              //       CircularProgressIndicator(value: downloadProgress.progress),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
      ),
    );
  }

  void _removeMedia(BuildContext context) async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }

    var content = Text('Tem certeza?');

    var actions = [
      FlatButton(
        child: Text('Não'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Text('Sim'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ];

    simpleDialog(context, 'Remover', content, true, actions);
  }
}
