import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class UserAction extends Equatable {
  const UserAction({
    this.notificationType,
    this.data,
  });

  final NotificationTypeEnum? notificationType;
  final String? data;

  @override
  List<Object?> get props => <Object?>[
        notificationType,
        data,
      ];
}
