import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/general/entities/media_entity.dart';

class AlbumItemEntity extends Equatable {
  final String id;
  final String? titleAlbum;
  final DateTime? dateCreation;
  final List<MediaEntity> medias;

  const AlbumItemEntity(
      this.id, this.titleAlbum, this.dateCreation, this.medias);

  static Future<AlbumItemEntity> fromSnapshot(DocumentSnapshot snap) async {
    return AlbumItemEntity(
      snap.id,
      (snap.data() as Map)['titleAlbum'],
      (snap.data() as Map)["dateCreation"] != null
          ? DateTime.parse((snap.data() as Map)['dateCreation'].toDate().toString())
          : null,
      _toEntity((snap.data()as Map)['medias']),
    );
  }

  static List<MediaEntity> _toEntity(Iterable? field) {
    List<MediaEntity> result = <MediaEntity>[];

    if (field != null) {
      field.forEach((item) {
        result.add(MediaEntity.fromSnapshot(item));
      });
    }

    return result;
  }

  @override
  List<Object?> get props => [
        id,
        dateCreation,
        medias,
      ];
}
