import 'package:mozin/features/time_line/domain/entities/time_line_item_entity.dart';
import 'package:mozin/features/time_line/data/models/media_model.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/package_view/utils.dart';

class TimeLineItemModel {
  String id;
  String textPost;
  DateTime dateCreation;
  List<MediaModel> medias;

  TimeLineItemModel({
    this.id,
    this.textPost,  
    this.dateCreation,
    this.medias,
  });

  String get dateCreationFormatted => DateUtils.dateFormat(dateCreation);

  Map<String, dynamic> toJson() {
    return {
      'textPost': textPost,
      "medias": medias != null ? _toJsonMedias() : [],
    };
  }

  List<Map<String, dynamic>> _toJsonMedias() {
    return medias.map<Map<String, dynamic>>((item) => item.toJson()).toList();
  }

  static TimeLineItemModel fromEntity(TimeLineItemEntity entity) {
    return TimeLineItemModel(
      id: entity.id,
      textPost: entity.textPost,
      dateCreation: entity.dateCreation,
      medias: entity.medias.map((item) => MediaModel.fromEntity(item)).toList(),
    );
  }

  static List<GalleryImageModel> toGalleryImages(List<MediaModel> medias) {
    final List<GalleryImageModel> galleryItems = [];

    for (var i = 0; i < medias.length; i++) {
      var item = medias[i];
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
