import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mozin/modules/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/logger/models/logger_model.dart';

class LoggerRepository {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  void addLog(LoggerModel model) {
    // ignore: always_specify_types
    _instance.firestore.collection('logger').doc().set({
      'entryDate': DateTime.now(),
      'message': model.message,
      'login': model.login,
      'error': model.error,
      'extraInfo': model.extraInfo,
      'appVersion': model.appVersion,
      'appName': model.appName,
      'packageName': model.packageName,
      'deviceInfo': model.deviceInfo,
    }).then((dynamic onValue) {
      print('Success insert Log.');
    }).catchError((dynamic onError) {
      print('Falha ao salvar log $onError');
    });
  }

  //TODO:review
  // Future<dynamic> uploadFile(String userIdentifier, File file, String fileName) async {

  //   final String childPath = userIdentifier != null ? 'logger/$userIdentifier/$fileName' : 'logger/$fileName';

  //   final StorageReference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child(childPath);

  //   final StorageUploadTask uploadTask = storageReference.putFile(file);

  //   await uploadTask.onComplete;

  //   return storageReference.getDownloadURL();
  // }
}
