import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

class AddTaskCalendarModel extends AddTaskCalendar {
  
  const AddTaskCalendarModel();
  // const CalendarModel(
  //     {})
  //     : super();

  factory AddTaskCalendarModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return AddTaskCalendarModel(
      
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

  AddTaskCalendarModel copyWith() {
    return AddTaskCalendarModel();
  }
}
