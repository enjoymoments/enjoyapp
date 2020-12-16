import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/gallery_images/gallery_photo_source_type_enum.dart';
import 'package:uuid/uuid.dart';

List<Widget> buildPhotos(BuildContext context, List<Uint8List> images, double imageWidth) {
  List<GalleryImageModel> _galleryImages = _transformGalleryModel(images);
  List<Widget> _list = new List<Widget>();

  for (var i = 0; i < images.length; i++) {
    var item = images[i];

    _list.add(
      GestureDetector(
        onTap: () {
          ExtendedNavigator.of(context).push(
            Routes.gallery_photo_view_wrapper,
            arguments: GalleryPhotoViewWrapperArguments(
              loadingBuilder: (BuildContext context, ImageChunkEvent event) =>
                  CustomCircularProgressIndicator(),
              galleryPhotoSourceType: GalleryPhotoSourceTypeEnum.memory,
              galleryItems: _galleryImages,
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              initialIndex: i,
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
      ),
    );
  }

  return _list;
}

List<GalleryImageModel> _transformGalleryModel(List<Uint8List> images) {
  var _uuid = getItInstance<Uuid>();

  var _result = images.map((e) {
    return GalleryImageModel(id: _uuid.v4(), byte: e);
  }).toList();

  return _result;
}
