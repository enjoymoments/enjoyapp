import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class Notifications extends Equatable {
  const Notifications({
    this.id,
    this.data,
    this.dateTime,
    this.message,
    this.notificationType,
  });

  final String? id;
  final String? data;
  final DateTime? dateTime;
  final String? message;
  final NotificationTypeEnum? notificationType;

  @override
  List<Object?> get props => <Object?>[
    this.id,
    this.data,
    this.dateTime,
    this.message,
    this.notificationType,
  ];
}
