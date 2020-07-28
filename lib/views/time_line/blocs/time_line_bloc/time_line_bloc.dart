import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(TimelineState initialState) : super(initialState);

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
