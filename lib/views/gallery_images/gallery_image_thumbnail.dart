import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/views/shared/custom_dialog.dart';
import 'package:mozin/views/time_line/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:vibration/vibration.dart';

class GalleryImageThumbnail extends StatelessWidget {
  const GalleryImageThumbnail({
    Key key,
    @required this.galleryImageModel,
    @required this.addTimeLineBloc,
    @required this.onTap,
  }) : super(key: key);

  final GalleryImageModel galleryImageModel;
  final AddTimeLineBloc addTimeLineBloc;
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
              child: Image.file(
                galleryImageModel.file,
                fit: BoxFit.fill,
              ),
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
      Vibration.vibrate(duration: 50);
    }

    var content = Text('Tem certeza?');

    var actions = [
      FlatButton(
        child: Text(
          'Não',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Text(
          'Sim',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          addTimeLineBloc.add(RemoveMedia(galleryImageModel));
          Navigator.of(context).pop();
        },
      ),
    ];

    simpleDialog(context, 'Remover', content, true, actions);
  }
}
