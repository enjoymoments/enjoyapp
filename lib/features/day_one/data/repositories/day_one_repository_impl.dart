import 'package:mozin/features/day_one/data/datasources/day_one_remote_data_source.dart';
import 'package:mozin/features/day_one/domain/repositories/day_one_repository.dart';
import 'package:flutter/material.dart';

class DayOneRepositoryImpl implements DayOneRepository {
  DayOneRepositoryImpl({
    @required this.remoteDataSource,
  });

  final DayOneRemoteDataSource remoteDataSource;
}
