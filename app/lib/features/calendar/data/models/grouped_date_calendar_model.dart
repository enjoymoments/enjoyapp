import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/grouped_date_calendar.dart';

class GroupedDateCalendarModel extends GroupedDateCalendar {
  const GroupedDateCalendarModel({
    DateTime date,
    List<TaskCalendarModel> tasks,
  }) : super(
          date: date,
          tasks: tasks
        );

  factory GroupedDateCalendarModel.fromJson(Map<String, dynamic> json) {
    var listTasks = <TaskCalendarModel>[];

    if (json['tasks'] != null) {
      json['tasks'].forEach((dynamic v) {
        listTasks.add(TaskCalendarModel.fromJson(v));
      });
    }

    return GroupedDateCalendarModel(
      date: DateTime.tryParse(json['date']),
      tasks: listTasks,
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

  GroupedDateCalendarModel copyWith() {
    return GroupedDateCalendarModel();
  }
}
