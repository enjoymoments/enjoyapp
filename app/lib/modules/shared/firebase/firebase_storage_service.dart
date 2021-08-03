import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<dynamic> uploadFile(String userIdentifier, File file, String fileName) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$userIdentifier/$fileName');

    await storageReference.putFile(file);

    return storageReference.getDownloadURL();
  }

  Future<void> removeFile(String userIdentifier, String fileName) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$userIdentifier/$fileName');

    storageReference.delete();
  }
}
