import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({@required CalendarRepository calendarRepository})
      : assert(calendarRepository != null),
        _calendarRepository = calendarRepository,
        super(CalendarState.initial());

  final CalendarRepository _calendarRepository;

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
  }
}