import 'package:dartz/dartz.dart';
import 'package:mozin/features/calendar/data/models/activity_model.dart';

abstract class ActivityRepository {
  Future<Either<List<ActivityModel>, Exception>> getActivities();
}
