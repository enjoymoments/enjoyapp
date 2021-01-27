import 'package:mozin/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:mozin/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:flutter/material.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  FeedbackRepositoryImpl({
    @required this.remoteDataSource,
  });

  final FeedbackRemoteDataSource remoteDataSource;
}
