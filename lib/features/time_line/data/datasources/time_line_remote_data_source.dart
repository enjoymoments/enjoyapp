import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';
import 'package:mozin/features/time_line/domain/entities/time_line_item_entity.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';

abstract class TimelineRemoteDataSource {
  Future<String> addTimeLineItem(String timelineID, String userId, TimeLineItemModel model);
  Future<List<TimeLineItemModel>> getPosts(String timelineID, int limit);
  Future<void> deletePost(String timelineID, String postID);
}

class TimelineRemoteDataSourceImpl implements TimelineRemoteDataSource {
  TimelineRemoteDataSourceImpl(this.remoteClientRepository, this.remoteConfig);

  final RemoteClientRepository remoteClientRepository;
  final RemoteConfig remoteConfig;

  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();
  static String _collectionRoot = 'timeline';

  @override
  Future<String> addTimeLineItem(
      String timelineID, String userId, TimeLineItemModel model) async {
    var document = _instance.firestore
        .doc('$_collectionRoot/$timelineID')
        .collection('posts')
        .doc();

    var map = model.toJson();
    map['dateCreation'] = DateTime.now();
    map['author'] = _instance.firestore
        .collection('users')
        .doc(userId);

    await document.set(map);
    return Future.value(document.id);
  }

  @override
  Future<List<TimeLineItemModel>> getPosts(String timelineID, int limit) async {
    var collection = _instance.firestore
        .doc('$_collectionRoot/$timelineID')
        .collection('posts')
        .orderBy('dateCreation', descending: true)
        .limit(limit);

    var result = await collection.get();

    return result.docs.map(
      (item) {
        return TimeLineItemModel.fromEntity(
            TimeLineItemEntity.fromSnapshot(item));
      },
    ).toList();
  }

  @override
  Future<void> deletePost(String timelineID, String postID) async {
    var url = remoteConfig.getString(url_functions);

    await remoteClientRepository.dio
        .delete('$url/deleteTimeLineItem', queryParameters: {
      'timelineID': timelineID,
      'postID': postID,
    });
  }
}
