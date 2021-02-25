import 'package:equatable/equatable.dart';
import 'package:mozin/features/calendar/domain/entities/add_activity_calendar.dart';

class AddTaskCalendar extends Equatable {
  
  AddTaskCalendar({
    this.taskId,
    this.title,
    this.description,
    this.dateTime,
    this.activities,
  });

  final String taskId;
  String title;
  String description;
  DateTime dateTime; 
  List<AddActivityCalendar> activities;

  @override
  List<Object> get props => <Object>[
    this.taskId,
    this.title,
    this.description,
    this.dateTime,
    this.activities,
  ];
}
