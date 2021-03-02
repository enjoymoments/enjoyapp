import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_activity_calendar.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
import 'package:mozin/package_view/utils.dart';

part 'add_calendar_state.dart';

class AddCalendarCubit extends Cubit<AddCalendarState> {
  AddCalendarCubit({@required CalendarRepository calendarRepository})
      : assert(calendarRepository != null),
        _calendarRepository = calendarRepository,
        super(AddCalendarState.initial());

  final CalendarRepository _calendarRepository;

  void addActivity(AddActivityCalendarModel model) {
    state.model.activities.add(model);
    emit(state.copyWith(
      model: state.model,
      isError: false,
      errorMessage: '',
    ));
  }

  void removeActivity(AddActivityCalendarModel model) {
    state.model.activities.remove(model);
    emit(state.copyWith(
      model: state.model,
      isError: false,
      errorMessage: '',
    ));
  }

  void setModel({
    String title,
    String description,
    DateTime datetime,
    List<AddActivityCalendar> activities,
  }) {
    state.model.title = title ?? state.model.title;
    state.model.dateTime = datetime ?? state.model.dateTime;
    state.model.description = description ?? state.model.description;
    state.model.activities = activities ?? state.model.activities;

    emit(
      state.copyWith(
        model: state.model,
        isError: false,
        errorMessage: '',
        forceRefresh: StateUtils.generateRandomNumber(),
      ),
    );
  }

  void save() {
    if (state.model.title == null || state.model.title == "") {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Informe o título',
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
      return;
    }

    if (state.model.dateTime == null) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Informe a data e hora',
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
      return;
    }

    if (state.model.activities.length == 0) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Selecione ao menos uma atividade',
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
      return;
    }

    sendRequest();
  }

  void sendRequest() async {
    var _response = await _calendarRepository.addTaskInCalendar(state.model);

    _response.fold(
      (value) {
        if (value) {
          emit(state.copyWith(isError: false, isSuccess: true));
        } else {
          emit(state.copyWith(
              isError: true,
              isSuccess: false,
              errorMessage: 'Ops... houve um erro. Tente novamente!'));
        }
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
