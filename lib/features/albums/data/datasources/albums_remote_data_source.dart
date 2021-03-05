import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/domain/entities/album_item_entity.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class AlbumsRemoteDataSource {
  Future<String> addAlbum(String userId, AlbumItemModel model);
  Future<List<AlbumItemModel>> getAlbums(String userId, int limit);
}

class AlbumsRemoteDataSourceImpl implements AlbumsRemoteDataSource {
  AlbumsRemoteDataSourceImpl(this.remoteClientRepository, this.remoteConfig);

  final RemoteClientRepository remoteClientRepository;
  final RemoteConfig remoteConfig;

  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  @override
  Future<String> addAlbum(
      String userId, AlbumItemModel model) async {
    var document = _instance.firestore
        .doc('users/$userId')
        .collection('albums')
        .doc();

    var map = model.toJson();
    map['dateCreation'] = DateTime.now();

    await document.set(map);
    return Future.value(document.id);
  }

  @override
  Future<List<AlbumItemModel>> getAlbums(String userId, int limit) async {
    var collection = _instance.firestore
        .doc('users/$userId')
        .collection('albums')
        .orderBy('dateCreation', descending: true)
        .limit(limit);

    var result = await collection.get();

    var list = List<AlbumItemModel>();

    for (var item in result.docs) {
      var snap = await AlbumItemEntity.fromSnapshot(item);
      list.add(AlbumItemModel.fromEntity(snap));
    }

    return list;
  }

  // @override
  // Future<void> deletePost(String timelineID, String postID) async {
  //   var url = remoteConfig.getString(url_functions);

  //   var _options = await remoteClientRepository.getOptions();

  //   await remoteClientRepository.dio
  //       .post('$url/deleteTimeLineItem', data: {
  //     'timelineID': timelineID,
  //     'postID': postID,
  //   }, options: _options);
  // }
}
