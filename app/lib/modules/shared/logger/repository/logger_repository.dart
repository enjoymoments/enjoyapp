import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:mozin/modules/shared/logger/models/logger_model.dart';

class LoggerRepository {
  final RemoteConfig? remoteConfig;

  LoggerRepository({this.remoteConfig});

  void addLog(LoggerModel model) {
    var _dio = Dio();
    try {
      var data = {
        'message': model.message,
        'login': model.login,
        'error': model.error,
        'extraInfo': model.extraInfo,
        'appVersion': model.appVersion,
        'appName': model.appName,
        'packageName': model.packageName,
        'deviceInfo': model.deviceInfo,
        'type': model.typeError.index,
      };

      var url = remoteConfig!.getString(url_functions);

      _dio
          .post('$url/writeLog', data: data)
          .then((value) => print('Success insert Log.'))
          .catchError((onError) => print('Fail insert log $onError'));
    } finally {
      _dio.close();
    }
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
