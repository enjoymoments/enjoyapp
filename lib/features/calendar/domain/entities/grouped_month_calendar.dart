import 'package:equatable/equatable.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

class GroupedMonthCalendar extends Equatable {
  
  const GroupedMonthCalendar({
    this.month,
    this.tasks,
  });

  final int month; 
  final List<AddTaskCalendar> tasks;

  @override
  List<Object> get props => <Object>[
    this.month,
    this.tasks,
  ];
}
