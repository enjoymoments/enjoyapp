import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/time_line/domain/entities/media_entity.dart';

class TimeLineItemEntity extends Equatable {
  final String id;
  final DateTime dateCreation;
  final List<MediaEntity> medias;

  const TimeLineItemEntity(this.id, this.dateCreation, this.medias);

  static TimeLineItemEntity fromSnapshot(DocumentSnapshot snap) {
    return TimeLineItemEntity(
      snap.id,
      snap.data()['dateCreation'] != null ? DateTime.parse(snap.data()['dateCreation'].toDate().toString()) : null,
      _toEntity(snap.data()['medias']),
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
        id,
        dateCreation,
        medias,
      ];
}
