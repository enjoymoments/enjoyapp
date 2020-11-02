import 'package:mozin/features/notifications/domain/entities/notifications.dart';

class NotificationsModel extends Notifications {
  
  const NotificationsModel();
  // const NotificationsModel(
  //     {})
  //     : super();

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return NotificationsModel(
      
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
