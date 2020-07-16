import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class FirebaseStorageService {
  Future<dynamic> uploadFile(String userIdentifier, File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$userIdentifier/${Path.basename(image.path)}');

    StorageUploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.onComplete;

    return storageReference.getDownloadURL();
  }

  Future<void> removeFile(String userIdentifier, String imageName) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/$userIdentifier/$imageName');

    storageReference.delete();
  }
}
