import 'package:mozin/features/interest/data/datasources/interest_remote_data_source.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:flutter/material.dart';

class InterestRepositoryImpl implements InterestRepository {
  InterestRepositoryImpl({
    @required this.remoteDataSource,
  });

  final InterestRemoteDataSource remoteDataSource;
}
