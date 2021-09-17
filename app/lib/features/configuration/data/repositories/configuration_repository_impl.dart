import 'package:mozin/features/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:mozin/features/configuration/domain/repositories/configuration_repository.dart';
import 'package:flutter/material.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  ConfigurationRepositoryImpl({
    required this.remoteDataSource,
  });

  final ConfigurationRemoteDataSource remoteDataSource;
}
