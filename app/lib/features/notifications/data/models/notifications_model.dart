import 'package:mozin/features/notifications/domain/entities/notifications.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/core_migrate/extension_utils.dart';

class NotificationsModel extends Notifications {
  const NotificationsModel({
    String? id,
    String? data,
    DateTime? dateTime,
    String? message,
    NotificationTypeEnum? notificationType,
  }) : super(
            id: id,
            data: data,
            dateTime: dateTime,
            message: message,
            notificationType: notificationType);

  String get dateCreationFormatted => dateTime!.dateCustomFormat('dd/MM/yyyy -').add_Hm().format(dateTime!);

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;

    return NotificationsModel(
      id: json['id'],
      data: json['data'],
      dateTime: DateTime.tryParse(json['dateTime']),
      message: json['message'],
      notificationType: NotificationTypeEnum(json['notificationType']),
    );
  }

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  NotificationsModel copyWith() {
    return NotificationsModel();
  }
}
