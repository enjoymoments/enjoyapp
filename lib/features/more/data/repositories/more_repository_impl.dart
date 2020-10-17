import 'package:mozin/features/more/data/datasources/more_remote_data_source.dart';
import 'package:mozin/features/more/domain/repositories/more_repository.dart';
import 'package:flutter/material.dart';

class MoreRepositoryImpl implements MoreRepository {
  MoreRepositoryImpl({
    @required this.remoteDataSource,
  });

  final MoreRemoteDataSource remoteDataSource;
}
