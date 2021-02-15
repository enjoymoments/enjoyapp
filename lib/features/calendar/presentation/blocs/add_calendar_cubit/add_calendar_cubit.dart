import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_calendar_state.dart';

class AddCalendarCubit extends Cubit<AddCalendarState> {
  AddCalendarCubit() : super(AddCalendarInitial());
}
