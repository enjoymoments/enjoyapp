import 'package:mozin/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mozin/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    @required this.remoteDataSource,
  });

  final HomeRemoteDataSource remoteDataSource;
}
