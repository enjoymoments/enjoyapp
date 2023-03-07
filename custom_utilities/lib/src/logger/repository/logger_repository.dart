import '../../../custom_utilities.dart';

class LoggerRepository {
  final String baseUrl;

  LoggerRepository({required this.baseUrl});

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

      _dio
          .post('$baseUrl/writeLog', data: data)
          .then((value) => print('Success insert Log.'))
          .catchError((onError) => print('Fail insert log $onError'));
    } finally {
      _dio.close();
    }
  }
}
