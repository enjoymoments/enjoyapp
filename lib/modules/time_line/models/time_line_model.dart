import 'package:mozin/modules/time_line/entities/time_line_item_entity.dart';
import 'package:mozin/modules/time_line/models/media_model.dart';
import 'package:mozin/views/shared/utils.dart';

class TimeLineItemModel {
  DateTime dateCreation;
  List<MediaModel> medias;

  TimeLineItemModel({
    this.dateCreation,
    this.medias,
  });

  String get dateCreationFormatted => DateUtils.dateFormat(dateCreation);

  Map<String, dynamic> toJson() {
    return {
      "medias": medias != null ? _toJsonMedias() : [],
    };
  }

  List<Map<String, dynamic>> _toJsonMedias() {
    return medias.map<Map<String, dynamic>>((item) => item.toJson()).toList();
  }

  static TimeLineItemModel fromEntity(TimeLineItemEntity entity) {
    return TimeLineItemModel(
      dateCreation: entity.dateCreation,
      medias: entity.medias.map((item) => MediaModel.fromEntity(item)).toList(),
    );
  }
}
