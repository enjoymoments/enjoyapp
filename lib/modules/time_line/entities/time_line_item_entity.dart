import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/time_line/entities/media_entity.dart';

class TimeLineItemEntity extends Equatable {
  final List<MediaEntity> medias;

  const TimeLineItemEntity(this.medias);

  static TimeLineItemEntity fromSnapshot(DocumentSnapshot snap) {
    return TimeLineItemEntity(
      _toEntity(snap.data['medias']),
    );
  }

  static List<MediaEntity> _toEntity(Iterable field) {
    List<MediaEntity> result = new List<MediaEntity>();

    if (field != null) {
      field.forEach((item) {
        result.add(MediaEntity.fromSnapshot(item));
      });
    }

    return result;
  }

  @override
  List<Object> get props => [
        medias,
      ];
}
