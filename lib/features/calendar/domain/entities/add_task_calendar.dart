import 'package:equatable/equatable.dart';
import 'package:mozin/features/calendar/domain/entities/add_activity_calendar.dart';

class AddTaskCalendar extends Equatable {
  
  const AddTaskCalendar({
    this.taskId,
    this.title,
    this.dateTime,
    this.activities,
  });

  final String taskId;
  final String title;
  final DateTime dateTime; 
  final List<AddActivityCalendar> activities;

  @override
  List<Object> get props => <Object>[
    this.taskId,
    this.title,
    this.dateTime,
    this.activities,
  ];
}
