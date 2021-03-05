import 'package:equatable/equatable.dart';

class MediaEntity extends Equatable {
  final String id;
  final int type;
  final String url;

  const MediaEntity(this.id, this.type, this.url);

  static MediaEntity fromSnapshot(Map<String, dynamic> map) {
    return MediaEntity(
      map['id'],
      map['type'],
      map['url'],
    );
  }

  @override
  List<Object> get props => [id, type, url];
}
