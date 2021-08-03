import 'package:dartz/dartz.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';

abstract class AlbumsRepository {
  Future<Either<String, Exception>> addAlbum(String userId, AlbumItemModel model);
  Future<Either<List<AlbumItemModel>, Exception>> getAlbums(
    String userId, int limit
  );
  Future<Either<bool, Exception>> deleteAlbum(String userId, String albumId);
}
