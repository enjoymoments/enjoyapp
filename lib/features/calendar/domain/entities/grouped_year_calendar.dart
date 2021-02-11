import 'package:equatable/equatable.dart';
import 'package:mozin/features/calendar/domain/entities/grouped_month_calendar.dart';

class GroupedYearCalendar extends Equatable {
  
  const GroupedYearCalendar({
    this.year,
    this.months,
  });

  final int year; 
  final List<GroupedMonthCalendar> months;

  @override
  List<Object> get props => <Object>[
    this.year,
    this.months,
  ];
}
