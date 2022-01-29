import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';

//TODO:null-safety
// extension NavigatorStateExtension on ExtendedNavigatorState {
//   void pushNamedIfNotCurrent(String routeName, {Object arguments}) {
//     if (!isCurrent(routeName)) {
//       push(routeName, arguments: arguments);
//     }
//   }

//   bool isCurrent(String routeName) {
//     bool isCurrent = false;
//     popUntil((route) {
//       if (route.settings.name == routeName) {
//         isCurrent = true;
//       }
//       return true;
//     });
//     return isCurrent;
//   }
// }

extension ImageToGallery on List<MediaModel> {
  List<GalleryImageModel> toGalleryImages() {
    final List<GalleryImageModel> galleryItems = [];

    for (var i = 0; i < this.length; i++) {
      var item = this[i];
      galleryItems.add(
        GalleryImageModel(
          id: item.id,
          index: i,
          //file: item,
          url: item.url,
        ),
      );
    }

    return galleryItems;
  }
}
