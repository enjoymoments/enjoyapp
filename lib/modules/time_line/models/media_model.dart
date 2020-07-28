import 'package:mozin/modules/time_line/entities/media_entity.dart';

class MediaModel {
  int type;
  String url;

  MediaModel({this.type, this.url});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(type: json['type'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "url": url,
    };
  }

  static MediaModel fromEntity(MediaEntity entity) {
    return MediaModel(
      type: entity.type,
      url: entity.url,
    );
  }
}
