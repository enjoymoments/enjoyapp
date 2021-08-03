import 'package:mozin/features/monitoring/data/datasources/monitoring_remote_data_source.dart';
import 'package:mozin/features/monitoring/domain/repositories/monitoring_repository.dart';
import 'package:flutter/material.dart';

class MonitoringRepositoryImpl implements MonitoringRepository {
  MonitoringRepositoryImpl({
    @required this.remoteDataSource,
  });

  final MonitoringRemoteDataSource remoteDataSource;
}
