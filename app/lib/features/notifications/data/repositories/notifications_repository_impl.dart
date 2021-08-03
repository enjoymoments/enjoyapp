import 'package:dartz/dartz.dart';
import 'package:mozin/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:mozin/features/notifications/data/models/notifications_model.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:mozin_core/utils.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({
    @required this.remoteDataSource,
  });

  final NotificationsRemoteDataSource remoteDataSource;

  @override
  Future<Either<List<NotificationsModel>, Exception>> getNotifications() async {
    try {
      var response = await remoteDataSource.getNotifications();
      return Left<List<NotificationsModel>, Exception>(response);
    } catch (e) {
      return Right<List<NotificationsModel>, Exception>(ExceptionsUtils.createException(e));
    }
  }
}
