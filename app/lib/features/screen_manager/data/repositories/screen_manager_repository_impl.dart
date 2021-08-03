import 'package:mozin/features/screen_manager/data/datasources/screen_manager_remote_data_source.dart';
import 'package:mozin/features/screen_manager/domain/repositories/screen_manager_repository.dart';
import 'package:flutter/material.dart';

class ScreenManagerRepositoryImpl implements ScreenManagerRepository {
  ScreenManagerRepositoryImpl({
    @required this.remoteDataSource,
  });

  final ScreenManagerRemoteDataSource remoteDataSource;
}
