import 'package:dartz/dartz.dart';
import 'package:mozin/features/feedback/data/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<Either<String, Exception>> addFeedback(FeedbackModel model);
}
