import 'package:mozin/features/user_action/domain/entities/user_action.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class UserActionModel extends UserAction {
  const UserActionModel({
    NotificationTypeEnum notificationType,
    String data,
  }) : super(
          notificationType: notificationType,
          data: data,
        );

  factory UserActionModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;

    return UserActionModel();
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

  UserActionModel copyWith() {
    return UserActionModel();
  }
}
