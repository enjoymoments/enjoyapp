import 'package:mozin/modules/firebase/firebase_instance_provider.dart';

class FirebaseService {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  //TODO:temporary
  static String _collectionRoot = 'jokes2';

  // Future<List<JokeModel>> getJokes(String userIdentifier) async {
  //   var jokesCollection = _instance.firestore
  //       .document('users/$userIdentifier')
  //       .collection(_collectionRoot);

  //   var result = await jokesCollection.getDocuments();
    
  //   return result.documents.map(
  //     (item) {
  //       return JokeModel.fromEntity(JokeEntity.fromSnapshot(item));
  //     },
  //   ).toList();
  // }

  // Future<String> addJoke(String userIdentifier, JokeModel model) async {
  //   try {
  //     var document = _instance.firestore
  //         .document('users/$userIdentifier')
  //         .collection(_collectionRoot)
  //         .document();

  //     var map = model.toJson();
  //     map['dateCreation'] = DateTime.now();

  //     document.setData(map);
  //     return Future.value(document.documentID);
  //   } catch (error) {
  //     return Future.value(null);
  //   }
  // }

  // Future<bool> updateJoke(String userIdentifier, JokeModel model) {
  //   try {
  //     var document = _instance.firestore
  //         .document('users/$userIdentifier')
  //         .collection(_collectionRoot)
  //         .document(model.id);
  //     var map = model.toJson();
  //     map['dateUpdate'] = DateTime.now();

  //     document.updateData(map);
  //     return Future.value(true);
  //   } catch (error) {
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> removeJoke(String userIdentifier, String jokeId) {
  //   try {
  //     var document = _instance.firestore
  //         .document('users/$userIdentifier')
  //         .collection(_collectionRoot)
  //         .document(jokeId);
  //     document.delete();
  //     return Future.value(true);
  //   } catch (error) {
  //     return Future.value(false);
  //   }
  // }
}
