import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

part 'unsynccouple_state.dart';

class UnsyncCoupleCubit extends Cubit<UnsyncCoupleState> {
  UnsyncCoupleCubit({
    required UserActionRepository userActionRepository,
  })  : assert(userActionRepository != null),
        _userActionRepository = userActionRepository,
        super(UnsyncCoupleState.initial());

  final UserActionRepository _userActionRepository;

  void unsyncCouple() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    Either<ResponseDefaultModel, Exception> _response =
        await _userActionRepository.addUserAction(
            model: UserActionModel(
                notificationType: NotificationTypeEnum.UnsyncCouple));

    _response.fold((model) {
      if (model.isSuccess!) {
        getItInstance<UserWrapper>().setCoupleId(model.data);
      }

      emit(state.copyWith(
        isLoading: false,
        isError: !model.isSuccess!,
        isSuccess: model.isSuccess,
      ));
    }, (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
      ));
    });
  }
}
