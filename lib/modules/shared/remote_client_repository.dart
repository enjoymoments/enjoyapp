import 'package:dartz/dartz.dart';
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

  Future<Either<Response, Exception>> query(String doc,
      {Map<String, dynamic> variables}) async {
    try {
      Options _opt = _getOptions();

      var jsonMap = {'query': doc, 'variables': variables};

      Response response = await dio.post(url, data: jsonMap, options: _opt);
      return Left<Response, Exception>(response);
    } on Exception catch (e) {
      //TODO:implement logger here
      return Right<Response, Exception>(e);
    }
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
