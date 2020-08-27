import 'package:mozin/modules/time_line/entities/time_line_item_entity.dart';
import 'package:mozin/modules/time_line/models/media_model.dart';

class TimeLineItemModel {
  List<MediaModel> medias;

  TimeLineItemModel({this.medias,});

  factory TimeLineItemModel.fromJson(Map<String, dynamic> json) {
    return TimeLineItemModel(
        medias: json['medias']);
  }

  Map<String, dynamic> toJson() {
    return {
      "medias": medias != null ? _toJsonMedias() : [],
    };
  }

  List<Map<String, dynamic>> _toJsonMedias() {
    return medias.map<Map<String, dynamic>>(
      (item) => item.toJson()
    ).toList();
  }

  static TimeLineItemModel fromEntity(TimeLineItemEntity entity) {
    return TimeLineItemModel(
      medias:
          entity.medias.map((item) => MediaModel.fromEntity(item)).toList(),
    );
  }
}
