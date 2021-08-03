import 'package:mozin/features/time_line/data/datasources/time_line_remote_data_source.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class TimelineRepositoryImpl implements TimelineRepository {
  TimelineRepositoryImpl({
    @required this.remoteDataSource,
  });

  final TimelineRemoteDataSource remoteDataSource;

  @override
  Future<String> addTimeLineItem(
      String timelineID, String userId, TimeLineItemModel model) {
    try {
      return remoteDataSource.addTimeLineItem(timelineID, userId, model);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<List<TimeLineItemModel>> getPosts(String timelineID, int limit) {
    try {
      return remoteDataSource.getPosts(timelineID, limit);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<void> deletePost(String timelineID, String postID) {
    try {
      return remoteDataSource.deletePost(timelineID, postID);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GetTimeLineModel>> getTimelines(String userId) {
    try {
      return remoteDataSource.getTimelines(userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> setTimeline(List<String> users, TimeLineTypeEnum type) {
    try {
      return remoteDataSource.setTimeline(users, type);
    } catch (e) {
      rethrow;
    }
  }
}
