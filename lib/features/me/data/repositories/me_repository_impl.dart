import 'package:mozin/features/me/data/datasources/me_remote_data_source.dart';
import 'package:mozin/features/me/domain/repositories/me_repository.dart';
import 'package:flutter/material.dart';

class MeRepositoryImpl implements MeRepository {
  MeRepositoryImpl({
    @required this.remoteDataSource,
  });

  final MeRemoteDataSource remoteDataSource;
}
