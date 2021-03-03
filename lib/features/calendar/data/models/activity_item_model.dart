import 'package:mozin/features/calendar/domain/entities/activity_item.dart';

class ActivityItemModel extends ActivityItem {
  ActivityItemModel({
    String id,
    String name,
    int codePoint,
    bool isSelected,
  }) : super(
          id: id,
          name: name,
          codePoint: codePoint,
          isSelected: isSelected,
        );

  factory ActivityItemModel.fromJson(Map<String, dynamic> json) {
    return ActivityItemModel(
      id: json['id'],
      name: json['name'],
      codePoint: json['codePoint'],
      isSelected: false,
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

  ActivityItemModel copyWith({
    String id,
    String name,
    int codePoint,
    bool isSelected,
  }) {
    return ActivityItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      codePoint: codePoint ?? this.codePoint,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
