import 'package:mozin/features/intro/data/datasources/intro_remote_data_source.dart';
import 'package:mozin/features/intro/domain/repositories/intro_repository.dart';
import 'package:flutter/material.dart';

class IntroRepositoryImpl implements IntroRepository {
  IntroRepositoryImpl({
    @required this.remoteDataSource,
  });

  final IntroRemoteDataSource remoteDataSource;
}
