import 'package:dartz/dartz.dart';
import 'package:mozin/features/notifications/data/models/notifications_model.dart';

abstract class NotificationsRepository {
  Future<Either<List<NotificationsModel>, Exception>> getNotifications();
}
