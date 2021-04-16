import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class InviteRemoteDataSource {
  Future<String> generateShareUrl(String userInternalId);
}

class InviteRemoteDataSourceImpl implements InviteRemoteDataSource {
  InviteRemoteDataSourceImpl({@required this.remoteClientRepository, @required this.remoteConfig});

  final RemoteClientRepository remoteClientRepository;
  final RemoteConfig remoteConfig;

  @override
  Future<String> generateShareUrl(String userInternalId) async {
    var url = remoteConfig.getString(url_functions);

    var _options = await remoteClientRepository.getOptions();

    var _response = await remoteClientRepository.dio
        .post('$url/generateShareUrl', data: {
      'path': userInternalId,
    }, options: _options);

    return _response.data;
  }
}
