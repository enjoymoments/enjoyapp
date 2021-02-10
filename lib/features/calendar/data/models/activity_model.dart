import 'package:mozin/features/calendar/data/models/activity_item_model.dart';
import 'package:mozin/features/calendar/domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    String id,
    String sessionName,
    List<ActivityItemModel> activities,
  }) : super(
          id: id,
          sessionName: sessionName,
          activities: activities,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    var listActivities = <ActivityItemModel>[];

    if (json['activities'] != null) {
      json['activities'].forEach((dynamic v) {
        listActivities.add(ActivityItemModel.fromJson(v));
      });
    }

    return ActivityModel(
      id: json['id'],
      sessionName: json['sessionName'],
      activities: listActivities,
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

  ActivityModel copyWith() {
    return ActivityModel();
  }
}
