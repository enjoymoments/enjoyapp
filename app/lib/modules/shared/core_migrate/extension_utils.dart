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

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(this.year, this.month, this.day, time.hour, time.minute);
  }

  TimeOfDay timeOfDayFromDateTime() {
    return TimeOfDay(hour: this.hour, minute: this.minute);
  }

  DateTime clearTime() {
    return DateTime(this.year, this.month, this.day, 0, 0, 0, 0, 0);
  }

  String formattedHourMinute() {
    return DateFormat().add_Hm().format(this);
  }

  DateFormat dateCustomFormat(String pattern) {
    return DateFormat(pattern);
  }

  String dateOnlyFormat() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

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
