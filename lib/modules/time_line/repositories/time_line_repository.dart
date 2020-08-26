import 'package:mozin/modules/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/time_line/entities/time_line_item_entity.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';

class TimeLineRepository {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();
  static String _collectionRoot = 'timeline';

  Future<String> addTimeLineItem(
      String timelineID, TimeLineItemModel model) async {
    var document = _instance.firestore
        .document('$_collectionRoot/$timelineID')
        .collection('posts')
        .document();

    var map = model.toJson();
    map['dateCreation'] = DateTime.now();

    await document.setData(map);
    return Future.value(document.documentID);
  }

  Future<List<TimeLineItemModel>> getPosts(String timelineID) async {
    var collection = _instance.firestore
        .document('$_collectionRoot/$timelineID')
        .collection('posts');

    var result = await collection.getDocuments();

    return result.documents.map(
      (item) {
        return TimeLineItemModel.fromEntity(
            TimeLineItemEntity.fromSnapshot(item));
      },
    ).toList();
  }
}
