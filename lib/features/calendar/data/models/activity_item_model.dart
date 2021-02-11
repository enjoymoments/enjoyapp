import 'package:mozin/features/calendar/domain/entities/activity_item.dart';

class ActivityItemModel extends ActivityItem {
  const ActivityItemModel({
    String id,
    String name,
    int codePoint,
  }) : super(
          id: id,
          name: name,
          codePoint: codePoint
        );

  factory ActivityItemModel.fromJson(Map<String, dynamic> json) {
    return ActivityItemModel(
      id: json['id'],
      name: json['name'],
      codePoint: json['codePoint'],
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
