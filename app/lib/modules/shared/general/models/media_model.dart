import 'package:mozin/modules/shared/general/entities/media_entity.dart';
import 'package:mozin/modules/shared/general/models/base_image_model.dart';

class MediaModel extends BaseImageModel {
  int? type;
  String? url;

  MediaModel({String? id, this.type, this.url}) : super(id: id);

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(id: json['id'], type: json['type'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "url": url,
    };
  }

  static MediaModel fromEntity(MediaEntity entity) {
    return MediaModel(
      id: entity.id,
      type: entity.type,
      url: entity.url,
    );
  }
}
