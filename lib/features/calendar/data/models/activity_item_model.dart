import 'package:mozin/features/calendar/domain/entities/activity_item.dart';

class ActivityItemModel extends ActivityItem {
  const ActivityItemModel({
    String id,
    String name,
  }) : super(
          id: id,
          name: name,
        );

  factory ActivityItemModel.fromJson(Map<String, dynamic> json) {
    return ActivityItemModel(
      id: json['id'],
      name: json['name'],
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

  ActivityItemModel copyWith() {
    return ActivityItemModel();
  }
}
