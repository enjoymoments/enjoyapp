import 'package:dartz/dartz.dart';
import 'package:mozin/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:mozin/features/feedback/data/models/feedback_model.dart';
import 'package:mozin/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:flutter/material.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  FeedbackRepositoryImpl({
    required this.remoteDataSource,
  });

  final FeedbackRemoteDataSource? remoteDataSource;

  @override
  Future<Either<String, Exception>> addFeedback(FeedbackModel model) async {
    try {
      var response = await remoteDataSource!.addFeedback(model);
      return Left<String, Exception>(response);
    } on dynamic catch (e) {
      return Right<String, Exception>(e);
    }
  }
}
