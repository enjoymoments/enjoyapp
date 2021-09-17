import 'package:mozin/features/albums/domain/entities/album_item_entity.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';

class AlbumItemModel {
  String? id;
  String? titleAlbum;
  DateTime? dateCreation;
  List<MediaModel>? medias;

  AlbumItemModel({
    this.id,
    this.titleAlbum,
    this.dateCreation,
    this.medias,
  });

  Map<String, dynamic> toJson() {
    return {
      'titleAlbum': titleAlbum,
      "medias": medias != null ? _toJsonMedias() : [],
    };
  }

  List<Map<String, dynamic>> _toJsonMedias() {
    return medias!.map<Map<String, dynamic>>((item) => item.toJson()).toList();
  }

  static AlbumItemModel fromEntity(AlbumItemEntity entity) {
    return AlbumItemModel(
      id: entity.id,
      titleAlbum: entity.titleAlbum,
      dateCreation: entity.dateCreation,
      medias: entity.medias.map((item) => MediaModel.fromEntity(item)).toList(),
    );
  }
}
