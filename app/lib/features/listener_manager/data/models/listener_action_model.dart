import 'package:mozin/features/listener_manager/domain/entities/listener_action_type.dart';

class ListenerActionModel {
  final ListenerActionTypeEnum type;

  ListenerActionModel({
    this.type
  });

  factory ListenerActionModel.fromJson(Map<String, dynamic> json) {
    return ListenerActionModel(
      type: ListenerActionTypeEnum(json['type'] ?? 0),
    );
  }
}
