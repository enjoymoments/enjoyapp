import 'package:dartz/dartz.dart';
import 'package:mozin/features/calendar/data/datasources/activity_remote_data_source.dart';
import 'package:mozin/features/calendar/data/models/activity_model.dart';
import 'package:mozin/features/calendar/domain/repositories/activity_repository.dart';
import 'package:flutter/material.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl({
    required this.remoteDataSource,
  });

  final ActivityRemoteDataSource? remoteDataSource;

  @override
  Future<Either<List<ActivityModel>, Exception>> getActivities() async {
    try {
      var response = await remoteDataSource!.getActivities();
      return Left<List<ActivityModel>, Exception>(response);
    } on dynamic catch (e) {
      return Right<List<ActivityModel>, Exception>(e);
    }
  }
}
