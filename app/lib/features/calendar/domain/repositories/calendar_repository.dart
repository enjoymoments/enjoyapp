import 'package:dartz/dartz.dart';
import 'package:mozin/features/calendar/data/models/grouped_date_calendar_model.dart';
import 'package:mozin/features/calendar/data/models/grouped_year_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';

abstract class CalendarRepository {
  Future<Either<bool?, Exception>> addTaskInCalendar(AddTaskCalendar? model);
  Future<Either<bool?, Exception>> removeTaskInCalendar(String? taskId);
  Future<Either<List<GroupedDateCalendarModel>, Exception>> getTasksInCalendar();
  Future<Either<List<GroupedYearCalendarModel>, Exception>> getTasksUserCalendarGroupedByYear();
}
