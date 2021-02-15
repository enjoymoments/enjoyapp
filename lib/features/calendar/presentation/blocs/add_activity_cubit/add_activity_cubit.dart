import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/calendar/data/models/activity_model.dart';
import 'package:mozin/features/calendar/domain/repositories/activity_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'add_activity_state.dart';

class AddActivityCubit extends Cubit<AddActivityState> {
  AddActivityCubit({@required ActivityRepository activityRepository})
      : assert(activityRepository != null),
        _activityRepository = activityRepository,
        super(AddActivityState.initial());

  final ActivityRepository _activityRepository;

  void getActivities() async {
    var response = await _activityRepository.getActivities();
    response.fold((activities) {
      return emit(state.copyWith(isLoading: false, activities: activities));
    }, (exception) {
      return emit(state.copyWith(isLoading: false, isError: true));
    });
  }
}
