import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/calendar/data/models/grouped_date_calendar_model.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin/modules/shared/core_migrate/extension_utils.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required CalendarRepository calendarRepository})
      : assert(calendarRepository != null),
        _calendarRepository = calendarRepository,
        super(CalendarState.initial());

  final CalendarRepository _calendarRepository;

  void selectedEvents(List selectedEventsParameter) {
    emit(state.copyWith(selectedEvents: selectedEventsParameter));
  }

  void loadTasks() async {
    var _response = await _calendarRepository.getTasksInCalendar();

    _response.fold(
      (value) {
        Map<DateTime?, List?> _events = {};

        for (var item in value) {
          _events[item.date] = item.tasks;
        }

        emit(
          state.copyWith(
            events: _events,
            model: value,
            selectedEvents: _events[DateTime.now().clearTime()] ?? []
          ),
        );
      },
      (error) {
        emit(state.copyWith(
            isError: true,
            isSuccess: false,
            errorMessage: 'Ops... houve um erro. Tente novamente!'));
      },
    );
  }
}
