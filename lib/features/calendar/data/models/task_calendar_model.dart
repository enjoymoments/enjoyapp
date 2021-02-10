import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

class TaskCalendarModel extends AddTaskCalendar {
  
  const TaskCalendarModel();
  // const CalendarModel(
  //     {})
  //     : super();

  factory TaskCalendarModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return TaskCalendarModel(
      
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
