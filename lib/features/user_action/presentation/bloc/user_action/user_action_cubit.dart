import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'user_action_state.dart';

class UserActionCubit extends Cubit<UserActionState> {
  UserActionCubit({
    @required UserActionRepository userActionRepository,
  })  : assert(userActionRepository != null),
        _userActionRepository = userActionRepository,
        super(UserActionState.initial());

  final UserActionRepository _userActionRepository;

  void syncUser(String fromUserId) async {
    Either<ResponseDefaultModel, Exception> _response =
        await _userActionRepository.addUserAction(
      model: UserActionModel(
        notificationType: NotificationTypeEnum.SyncCouple,
        data: fromUserId,
      ),
    );

    _response.fold((model) {
      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
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
