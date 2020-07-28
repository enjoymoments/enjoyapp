import 'package:equatable/equatable.dart';

class MediaEntity extends Equatable {
  final int type;
  final String url;

  const MediaEntity(this.type, this.url);

  static MediaEntity fromSnapshot(Map<String, dynamic> map) {
    return MediaEntity(
      map['type'],
      map['url'],
    );
  }

  @override
  List<Object> get props => [type, url];
}
