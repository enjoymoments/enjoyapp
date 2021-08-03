
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/grouped_month_calendar.dart';

class GroupedMonthCalendarModel extends GroupedMonthCalendar {
  const GroupedMonthCalendarModel({
    int month,
    List<TaskCalendarModel> tasks,
  }) : super(
          month: month,
          tasks: tasks,
        );

  factory GroupedMonthCalendarModel.fromJson(Map<String, dynamic> json) {
    var listTasks = <TaskCalendarModel>[];

    if (json['tasks'] != null) {
      json['tasks'].forEach((dynamic v) {
        listTasks.add(TaskCalendarModel.fromJson(v));
      });
    }

    return GroupedMonthCalendarModel(
      month: json['month'],
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

  GroupedMonthCalendarModel copyWith() {
    return GroupedMonthCalendarModel();
  }
}
