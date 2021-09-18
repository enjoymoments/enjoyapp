import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:custom_view/custom_circular_progress_indicador.dart';
import 'package:mozin/modules/shared/custom_view_migrate/gallery_images/gallery_photo_source_type_enum.dart';
import 'package:uuid/uuid.dart';

List<Widget> buildPhotos(
    BuildContext context, List<Uint8List> images, double imageWidth) {
  List<GalleryImageModel> _galleryImages = _transformGalleryModel(images);
  List<Widget> _list = <Widget>[];

  for (var i = 0; i < images.length; i++) {
    var item = images[i];

    _list.add(LoadPhotoItem(
      galleryImages: _galleryImages,
      index: i,
      item: item,
      imageWidth: imageWidth,
    ));
  }

  return _list;
}

List<GalleryImageModel> _transformGalleryModel(List<Uint8List> images) {
  Uuid? _uuid = getItInstance<Uuid>();

  var _result = images.map((e) {
    return GalleryImageModel(id: _uuid.v4(), byte: e);
  }).toList();

  return _result;
}

class LoadPhotoItem extends StatelessWidget {
  final List<GalleryImageModel> galleryImages;
  final int index;
  final Uint8List item;
  final double imageWidth;

  const LoadPhotoItem({
    Key? key,
    required this.galleryImages,
    required this.index,
    required this.item,
    required this.imageWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
          Gallery_photo_view_wrapper_screen(
            loadingBuilder: (BuildContext context, ImageChunkEvent? event) =>
                CustomCircularProgressIndicator(),
            galleryPhotoSourceType: GalleryPhotoSourceTypeEnum.memory,
            galleryItems: galleryImages,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            initialIndex: index,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
      child: Container(
        height: SizeConfig.sizeByPixel(100),
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.memory(item, fit: BoxFit.cover, width: imageWidth),
            ],
          ),
        ),
      ),
    );
  }
}
