import 'package:dartz/dartz.dart';
import 'package:mozin/features/calendar/data/datasources/calendar_remote_data_source.dart';
import 'package:mozin/features/calendar/data/models/grouped_year_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:flutter/material.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl({
    @required this.remoteDataSource,
  });

  final CalendarRemoteDataSource remoteDataSource;

  @override
  Future<Either<bool, Exception>> addTaskInCalendar(
      AddTaskCalendar model) async {
    try {
      var response = await remoteDataSource.addTaskInCalendar(model);
      return Left<bool, Exception>(response);
    } on dynamic catch (e) {
      return Right<bool, Exception>(e);
    }
  }

  @override
  Future<Either<List<GroupedYearCalendarModel>, Exception>>
      getTasksInCalendar() async {
    try {
      var response = await remoteDataSource.getTasksInCalendar();
      return Left<List<GroupedYearCalendarModel>, Exception>(response);
    } on dynamic catch (e) {
      return Right<List<GroupedYearCalendarModel>, Exception>(e);
    }
  }

  @override
  Future<Either<bool, Exception>> removeTaskInCalendar(String taskId) async {
    try {
      var response = await remoteDataSource.removeTaskInCalendar(taskId);
      return Left<bool, Exception>(response);
    } on dynamic catch (e) {
      return Right<bool, Exception>(e);
    }
  }
}
