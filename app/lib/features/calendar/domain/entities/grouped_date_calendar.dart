import 'package:equatable/equatable.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

class GroupedDateCalendar extends Equatable {
  
  const GroupedDateCalendar({
    this.date,
    this.tasks,
  });

  final DateTime? date; 
  final List<AddTaskCalendar>? tasks;

  @override
  List<Object?> get props => <Object?>[
    this.date,
    this.tasks,
  ];
}
