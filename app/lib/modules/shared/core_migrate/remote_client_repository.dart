import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/logger/enums/logger_type_enum.dart';
import 'package:mozin/modules/shared/logger/models/logger_model.dart';
import 'package:mozin/modules/shared/logger/service/logger_service.dart';

class RemoteClientRepository {
  RemoteClientRepository({
    required Dio dio,
    required String url,
    required LoggerService loggerService,
  })  : assert(dio != null),
        _dio = dio,
        assert(url != null),
        _url = url,
        assert(loggerService != null),
        _loggerService = loggerService;

  final Dio _dio;
  final String _url;
  final LoggerService _loggerService;

  Future<dynamic> query(String doc, {Map<String, dynamic>? variables}) async {
    Options _opt = await _getOptions();

    var jsonMap = {'query': doc, 'variables': variables};

    Response response = await _dio
        .post(_url, data: jsonMap, options: _opt)
        .catchError((onError) {
      _logger(onError, jsonMap);
      throw onError;
    });

    return response.data;
  }

  Future<dynamic> post(String url, {data}) async {
    Options _opt = await _getOptions();

    return _dio.post(url, data: data, options: _opt).catchError((onError) {
      _logger(onError, data);
      throw onError;
    });
  }

  Future<Options> _getOptions() async {
    return Options(
      contentType: 'application/json',
      headers: await _getHeaders(),
    );
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    var _authenticationRepository = getItInstance<AuthenticationRepository>();
    var _token = await _authenticationRepository.getToken();

    if (_token != null) {
      return {
        'Accept': '*/*',
        'Authorization': 'Bearer ' + _token,
      };
    }

    return {
      'Accept': '*/*',
    };
  }

  void _logger(dynamic onError, Map<String, dynamic>? jsonMap) {
    _loggerService.addLogAsync(
      LoggerModel(
        typeError: LoggerTypeEnum.Error,
        // ignore: always_specify_types
        error: {
          'body': onError?.toString(),
        },
        message: onError.message,
        // ignore: always_specify_types
        extraInfo: {
          'query': jsonMap,
        },
      ),
    );
  }
}
