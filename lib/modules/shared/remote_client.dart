import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mozin/remote_config.dart';
import 'package:mozin/setup.dart';

//TODO:in development

class RemoteClient {
  Future<String> query(String doc, {Map<String, dynamic> variables}) async {
    try {
      RemoteConfig _remoteConfig = getItInstance<RemoteConfig>();

      String _url =_remoteConfig.getString(url_endpoint);
      Dio _dio = Dio();

      Options _opt = Options(
        contentType: 'application/json',
        headers: {
          'Accept': '*/*'
        },
      );

      var jsonMap = {'query': doc, 'variables': variables};

      Response response = await _dio.post(_url, data: jsonMap, options: _opt);
      print(response);
      return response.toString();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
