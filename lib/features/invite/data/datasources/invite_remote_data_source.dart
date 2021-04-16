import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class InviteRemoteDataSource {
  Future<String> generateShareUrl(String userInternalId);
}

class InviteRemoteDataSourceImpl implements InviteRemoteDataSource {
  InviteRemoteDataSourceImpl(
      {@required this.remoteClientRepository, @required this.remoteConfig});

  final RemoteClientRepository remoteClientRepository;
  final RemoteConfig remoteConfig;

  @override
  Future<String> generateShareUrl(String userInternalId) async {
    var url = remoteConfig.getString(url_functions);

    var _response = await remoteClientRepository.post(
      '$url/generateShareUrl',
      data: {
        'path': userInternalId,
      },
    );

    return _response.data;
  }
}
