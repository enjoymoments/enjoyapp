import 'package:bloc/bloc.dart';
import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'add_calendar_state.dart';

class AddCalendarCubit extends Cubit<AddCalendarState> {
  AddCalendarCubit() : super(AddCalendarState.initial());

  void addActivity(AddActivityCalendarModel model) {
    state.activities.add(model);
    emit(state.copyWith(activities: state.activities));
  }

  void removeActivity(AddActivityCalendarModel model) {
    state.activities.remove(model);
    emit(state.copyWith(activities: state.activities));
  }

  //TODO:in test
  void validateFields(TaskCalendarModel model) {
    if (model.title == null || model.title == "") {
      emit(state.copyWith(isError: true, errorMessage: 'Informe o título'));
      return;
    }

    DateTime _dateTimeParse = DateTime.tryParse(model.dateTime.toUtc().toString());
    if (_dateTimeParse == null) {
      emit(state.copyWith(isError: true, errorMessage: 'Informe a data e hora'));
      return;
    }

    if (state.activities.length == 0) {
      emit(state.copyWith(isError: true, errorMessage: 'Selecione ao menos uma atividade'));
      return;
    }

    model.activities = state.activities;
    save();
  }

  void save() {
    emit(state.copyWith(isError: false, isSuccess: true));
  }
}
