import 'package:mozin/modules/time_line/entities/media_entity.dart';

class MediaModel {
  String id;
  int type;
  String url;

  MediaModel({this.id, this.type, this.url});

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
