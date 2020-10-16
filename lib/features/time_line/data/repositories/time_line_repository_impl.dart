import 'package:mozin/features/time_line/data/datasources/time_line_remote_data_source.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:flutter/material.dart';

class Time_lineRepositoryImpl implements Time_lineRepository {
  Time_lineRepositoryImpl({
    @required this.remoteDataSource,
  });

  final Time_lineRemoteDataSource remoteDataSource;
}
