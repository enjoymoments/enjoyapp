import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_dialog.dart';

class ImageItems extends StatelessWidget {
  final List<File> images;

  const ImageItems({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images != null) {
      return Wrap(
        children: images.map<Widget>(
          (image) {
            return _buildCardImage(context, image, null);
          },
        ).toList(),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  // Widget _buildImages(BuildContext context) {
  //   return BlocBuilder<ImageBloc, DefaultState>(
  //     bloc: imageBloc,
  //     builder: (BuildContext context, DefaultState state) {
  //       if (state is Loading) {
  //         return CustomCircularProgressIndicator();
  //       }

  //       if (state is LoadedImage) {
  //         currentJoke.medias = state.images;
  //         saveJoke(state.images);
  //       }

  //       if (currentJoke.medias != null) {
  //         return Wrap(
  //           children: currentJoke.medias.map<Widget>((image) {
  //             return _buildCardImage(context, image.url);
  //           }).toList(),
  //         );
  //       } else {
  //         return SizedBox.shrink();
  //       }
  //     },
  //   );
  // }

  Widget _buildCardImage(BuildContext context, File image, String imageUrl) {
    return GestureDetector(
      onLongPress: () {
        _removeMedia(context, imageUrl);
      },
      child: Container(
        height: 80,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.file(
            image,
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
    );
  }

  void _removeMedia(BuildContext context, String imageUrl) {
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
          // imageBloc.add(RemoveMedia(imageUrl, currentJoke.medias, false));
          Navigator.of(context).pop();
        },
      ),
    ];

    simpleDialog(context, 'Remover', content, true, actions);
  }
}
