import 'package:mozin/features/calendar/data/models/grouped_date_calendar_model.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required CalendarRepository calendarRepository})
      : _calendarRepository = calendarRepository,
        super(CalendarState.initial());

  final CalendarRepository _calendarRepository;

  void selectedEvents(List selectedEventsParameter) {
    emit(
      state.copyWith(
        selectedEvents: selectedEventsParameter,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ),
    );
  }

  void loadTasks() async {
    String? _coupleId = await getItInstance<UserWrapper>().getCoupleId();
    var _response = await _calendarRepository.getTasksInCalendar(_coupleId);

    _response.fold(
      (value) {
        Map<DateTime, List> _events = {};

        for (var item in value) {
          _events[item.date!.clearTime()] = item.tasks!;
        }

        emit(
          state.copyWith(
              events: _events,
              model: value,
              selectedEvents: _events[DateTime.now().clearTime()] ?? []),
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
