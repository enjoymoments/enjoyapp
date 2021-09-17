import 'package:flutter/material.dart';
import 'package:mozin/features/unsync_couple/data/datasources/unsync_couple_remote_data_source.dart';
import 'package:mozin/features/unsync_couple/domain/repositories/unsync_couple_repository.dart';

class UnsyncCoupleRepositoryImpl implements UnsyncCoupleRepository {
  UnsyncCoupleRepositoryImpl({
    required this.remoteDataSource,
  });

  final UnsyncCoupleRemoteDataSource remoteDataSource;
}
