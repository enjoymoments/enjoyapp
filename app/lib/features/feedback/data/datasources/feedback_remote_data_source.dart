import 'package:mozin/features/feedback/data/models/feedback_model.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class FeedbackRemoteDataSource {
  Future<String> addFeedback(FeedbackModel model);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  FeedbackRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  @override
  Future<String> addFeedback(FeedbackModel model) async {
    var document = _instance.firestore
        .collection('feedback')
        .doc();

    var map = model.toJson();
    map['dateCreation'] = DateTime.now();

    await document.set(map);
    return Future.value(document.id);
  }
}
