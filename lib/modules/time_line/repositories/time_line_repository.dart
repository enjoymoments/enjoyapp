import 'package:mozin/modules/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';

class TimeLineRepository {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();
  static String _collectionRoot = 'timeline';

  Future<String> addTimeLineItem(
      String timelineID, TimeLineItemModel model) async {
    try {
      var document = _instance.firestore
          .document('$_collectionRoot/$timelineID')
          .collection('posts')
          .document();

      var map = model.toJson();
      map['dateCreation'] = DateTime.now();

      await document.setData(map);
      return Future.value(document.documentID);
    } catch (error) {
      return Future.value(null);
    }
  }
}
