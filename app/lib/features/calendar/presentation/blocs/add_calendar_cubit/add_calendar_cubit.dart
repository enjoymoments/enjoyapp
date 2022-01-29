import 'package:bloc/bloc.dart';
import 'package:mozin/features/calendar/data/models/add_activity_calendar_model.dart';
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_activity_calendar.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'add_calendar_state.dart';

class AddCalendarCubit extends Cubit<AddCalendarState> {
  AddCalendarCubit({required CalendarRepository calendarRepository})
      : _calendarRepository = calendarRepository,
        super(AddCalendarState.initial());

  final CalendarRepository _calendarRepository;

  void addActivity(AddActivityCalendarModel model) {
    state.model!.activities!.add(model);
    emit(state.copyWith(
      model: state.model,
      isError: false,
      errorMessage: '',
    ));
  }

  void removeActivity(AddActivityCalendarModel model) {
    state.model!.activities!.remove(model);
    emit(state.copyWith(
      model: state.model,
      isError: false,
      errorMessage: '',
    ));
  }

  void setModel({
    String? taskId,
    String? title,
    String? description,
    String? url,
    DateTime? datetime,
    List<AddActivityCalendar>? activities,
  }) {
    state.model!.taskId = taskId ?? state.model!.taskId;
    state.model!.title = title ?? state.model!.title;
    state.model!.dateTime = datetime ?? state.model!.dateTime;
    state.model!.description = description ?? state.model!.description;
    state.model!.url = url ?? state.model!.url;
    state.model!.activities = activities ?? state.model!.activities;

    emit(
      state.copyWith(
        model: state.model,
        isError: false,
        errorMessage: '',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ),
    );
  }

  void save() {
    if (state.model!.title == null || state.model!.title == "") {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Informe o título',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    if (state.model!.dateTime == null) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Informe a data e hora',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    if (state.model!.url != null && state.model!.url!.isNotEmpty) {
      if (!state.model!.url!.regexUrlHasMatch()) {
        emit(state.copyWith(
          isError: true,
          errorMessage: 'Informe uma url válida',
          forceRefresh: StateUtils.generateRandomNumber() as int?,
        ));
        return;
      }
    }

    //TODO:in development
    // if (state.model!.activities!.length == 0) {
    //   emit(state.copyWith(
    //     isError: true,
    //     errorMessage: 'Selecione ao menos uma atividade',
    //     forceRefresh: StateUtils.generateRandomNumber() as int?,
    //   ));
    //   return;
    // }

    sendRequest();
  }

  void remove() async {
    String? _coupleId = await getItInstance<UserWrapper>().getCoupleId();
    var _response = await _calendarRepository.removeTaskInCalendar(
        _coupleId, state.model!.taskId);

    _response.fold(
      (value) {
        if (value!) {
          emit(
            state.copyWith(
              isError: false,
              isSuccess: true,
              forceRefresh: StateUtils.generateRandomNumber() as int?,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isError: true,
              isSuccess: false,
              errorMessage: 'Ops... houve um erro. Tente novamente!',
              forceRefresh: StateUtils.generateRandomNumber() as int?,
            ),
          );
        }
      },
      (error) {
        emit(
          state.copyWith(
            isError: true,
            isSuccess: false,
            errorMessage: 'Ops... houve um erro. Tente novamente!',
            forceRefresh: StateUtils.generateRandomNumber() as int?,
          ),
        );
      },
    );
  }

  void sendRequest() async {
    String? _coupleId = await getItInstance<UserWrapper>().getCoupleId();
    var _response =
        await _calendarRepository.addTaskInCalendar(_coupleId, state.model);

    _response.fold(
      (value) {
        if (value!) {
          emit(
            state.copyWith(
              isError: false,
              isSuccess: true,
              forceRefresh: StateUtils.generateRandomNumber() as int?,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isError: true,
              isSuccess: false,
              errorMessage: 'Ops... houve um erro. Tente novamente!',
              forceRefresh: StateUtils.generateRandomNumber() as int?,
            ),
          );
        }
      },
      (error) {
        emit(
          state.copyWith(
            isError: true,
            isSuccess: false,
            errorMessage: 'Ops... houve um erro. Tente novamente!',
            forceRefresh: StateUtils.generateRandomNumber() as int?,
          ),
        );
      },
    );
  }
}
