import 'package:bloc/bloc.dart';
import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
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
}
