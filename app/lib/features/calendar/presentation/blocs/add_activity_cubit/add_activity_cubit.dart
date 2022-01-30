import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/features/calendar/data/models/activity_item_model.dart';
import 'package:mozin/features/calendar/data/models/activity_model.dart';
import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/domain/repositories/activity_repository.dart';

part 'add_activity_state.dart';

class AddActivityCubit extends Cubit<AddActivityState> {
  AddActivityCubit({required ActivityRepository activityRepository})
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

  void setSeleted(List<AddActivityCalendarModel>? activitiesSelected) {
    var _activities = state.activities;
    if (activitiesSelected != null) {
      _setActivitySelected(_activities, activitiesSelected);
    }

    return emit(state.copyWith(isLoading: false, activities: _activities));
  }

  void _setActivitySelected(List<ActivityModel>? activities,
      List<AddActivityCalendarModel> activitiesSelected) {
    for (var activityItem in activitiesSelected) {
      var indexSession = activities!
          .indexWhere((element) => element.id == activityItem.sessionId);

      if (indexSession != -1) {
        var indexActivity = activities[indexSession]
            .activities!
            .indexWhere((element) => element.id == activityItem.activityId);
        if (indexActivity != -1) {
          var activity = activities[indexSession].activities![indexActivity];

          activities[indexSession].activities![indexActivity] =
              ActivityItemModel(
                  id: activity.id,
                  name: activity.name,
                  codePoint: activity.codePoint,
                  isSelected: true);
        }
      }
    }
  }
}
