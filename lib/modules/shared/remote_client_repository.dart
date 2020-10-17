import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/logger/service/logger_service.dart';

class RemoteClientRepository {
  final Dio dio;
  final String url;
  final LoggerService loggerService;

  RemoteClientRepository({
    @required this.dio,
    @required this.url,
    @required this.loggerService,
  });

  Future<dynamic> query(String doc, {Map<String, dynamic> variables}) async {
    Options _opt = _getOptions();

    var jsonMap = {'query': doc, 'variables': variables};

    Response response = await dio.post(url, data: jsonMap, options: _opt);
    //TODO:implement log here
    return response.data;
  }

  Options _getOptions() {
    return Options(
      contentType: 'application/json',
      headers: _getHeaders(),
    );
  }

  Map<String, dynamic> _getHeaders() {
    return {'Accept': '*/*'};
  }
}
