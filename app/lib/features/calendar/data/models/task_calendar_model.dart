import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

class TaskCalendarModel extends AddTaskCalendar {
  TaskCalendarModel({
    String? taskId,
    String? title,
    String? description,
    String? url,
    DateTime? dateTime,
    List<AddActivityCalendarModel>? activities,
  }) : super(
          taskId: taskId,
          title: title,
          description: description,
          url: url,
          dateTime: dateTime,
          activities: activities,
        );

  factory TaskCalendarModel.fromJson(Map<String, dynamic> json) {
    var listActivities = <AddActivityCalendarModel>[];

    if (json['activities'] != null) {
      json['activities'].forEach((dynamic v) {
        listActivities.add(AddActivityCalendarModel.fromJson(v));
      });
    }

    return TaskCalendarModel(
      taskId: json['taskId'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      dateTime: DateTime.tryParse(json['dateTime']),
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

  TaskCalendarModel copyWith() {
    return TaskCalendarModel();
  }
}
