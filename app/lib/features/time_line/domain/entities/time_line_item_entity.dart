import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/time_line/domain/entities/author_entity.dart';
import 'package:mozin/modules/shared/general/entities/media_entity.dart';

class TimeLineItemEntity extends Equatable {
  final String id;
  final AuthorEntity author;
  final String textPost;
  final DateTime dateCreation;
  final List<MediaEntity> medias;

  const TimeLineItemEntity(
      this.id, this.author, this.textPost, this.dateCreation, this.medias);

  static Future<TimeLineItemEntity> fromSnapshot(DocumentSnapshot snap) async {
    var _author = await _toAuthor(snap);
    
    return TimeLineItemEntity(
      snap.id,
      _author,
      (snap.data() as Map)['textPost'],
      (snap.data() as Map)['dateCreation'] != null
          ? DateTime.parse((snap.data() as Map)['dateCreation'].toDate().toString())
          : null,
      _toEntity((snap.data() as Map)['medias']),
    );
  }

  static Future<AuthorEntity> _toAuthor(DocumentSnapshot snap) async {
    DocumentReference documentAuthor = snap.get('author');
    if (documentAuthor != null) {
      var _author = await documentAuthor.get();
      return AuthorEntity.fromSnapshot(_author.data());
    }

    return null;
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
        textPost,
        dateCreation,
        medias,
      ];
}
