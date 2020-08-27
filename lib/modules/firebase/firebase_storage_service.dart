import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<dynamic> uploadFile(String userIdentifier, File file, String fileName) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$userIdentifier/$fileName');

    StorageUploadTask uploadTask = storageReference.putFile(file);

    await uploadTask.onComplete;

    return storageReference.getDownloadURL();
  }

  Future<void> removeFile(String userIdentifier, String fileName) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$userIdentifier/$fileName');

    storageReference.delete();
  }
}
