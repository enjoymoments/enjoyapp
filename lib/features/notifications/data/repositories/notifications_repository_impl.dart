import 'package:mozin/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:flutter/material.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({
    @required this.remoteDataSource,
  });

  final NotificationsRemoteDataSource remoteDataSource;
}
