import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/day_one/domain/repositories/day_one_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'day_one_event.dart';
part 'day_one_state.dart';

class DayOneBloc extends Bloc<DayOneEvent, DayOneState> {
  DayOneBloc({@required DayOneRepository dayOneRepository})
      : assert(dayOneRepository != null),
        _dayOneRepository = dayOneRepository,
        super(DayOneState.initial());

  final DayOneRepository _dayOneRepository;

  @override
  Stream<DayOneState> mapEventToState(
    DayOneEvent event,
  ) async* {
  }
}