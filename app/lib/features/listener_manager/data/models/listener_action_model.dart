import 'package:mozin/features/listener_manager/domain/entities/listener_action_type.dart';

class ListenerActionModel {
  final List<ListenerActionTypeEnum> actions;

  ListenerActionModel({this.actions});

  factory ListenerActionModel.fromJson(Map<String, dynamic> json) {
    List<ListenerActionTypeEnum> _actions = [];

    if (json != null && json['actions'] != null) {
      for (var item in json['actions']) {
        _actions.add(ListenerActionTypeEnum(item));
      }
    }

    return ListenerActionModel(
      actions: _actions,
    );
  }
}
