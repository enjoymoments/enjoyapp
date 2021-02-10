import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

class TaskCalendarModel extends AddTaskCalendar {
  const TaskCalendarModel({
    String taskId,
    String title,
    DateTime dateTime,
    List<AddActivityCalendarModel> activities,
  }) : super(
          taskId: taskId,
          title: title,
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
      dateTime: json['dateTime'],
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
