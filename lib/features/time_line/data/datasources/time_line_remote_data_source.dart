import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';
import 'package:mozin/features/time_line/domain/entities/time_line_item_entity.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';

abstract class TimelineRemoteDataSource {
  Future<String> addTimeLineItem(String timelineID, TimeLineItemModel model);
  Future<List<TimeLineItemModel>> getPosts(String timelineID);
}

class TimelineRemoteDataSourceImpl implements TimelineRemoteDataSource {
  TimelineRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();
  static String _collectionRoot = 'timeline';

  @override
  Future<String> addTimeLineItem(
      String timelineID, TimeLineItemModel model) async {
    var document = _instance.firestore
        .doc('$_collectionRoot/$timelineID')
        .collection('posts')
        .doc();

    var map = model.toJson();
    map['dateCreation'] = DateTime.now();

    await document.set(map);
    return Future.value(document.id);
  }

  @override
  Future<List<TimeLineItemModel>> getPosts(String timelineID) async {
    var collection = _instance.firestore
        .doc('$_collectionRoot/$timelineID')
        .collection('posts');

    var result = await collection.get();

    return result.docs.map(
      (item) {
        return TimeLineItemModel.fromEntity(
            TimeLineItemEntity.fromSnapshot(item));
      },
    ).toList();
  }
}
