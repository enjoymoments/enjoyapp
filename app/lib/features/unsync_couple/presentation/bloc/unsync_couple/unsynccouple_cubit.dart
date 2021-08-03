import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'unsynccouple_state.dart';

class UnsyncCoupleCubit extends Cubit<UnsyncCoupleState> {
  UnsyncCoupleCubit({
    @required UserActionRepository userActionRepository,
  })  : assert(userActionRepository != null),
        _userActionRepository = userActionRepository,
        super(UnsyncCoupleState.initial());

  final UserActionRepository _userActionRepository;

  void unsyncCouple() async {
    emit(state.copyWith(
      isLoading: true,
    ));

    var _userWrapper = getItInstance<UserWrapper>();
    var _user = _userWrapper.getUser;

    var _data = _user.timelines
        .where((element) => element.type == TimeLineTypeEnum.Couple)
        .toList();

    var _timelinesFormat = <String>[];

    _data.forEach((element) { 
      _timelinesFormat.add(element.id);
    });

    Either<ResponseDefaultModel, Exception> _response =
        await _userActionRepository.addUserAction(
            model: UserActionModel(
                notificationType: NotificationTypeEnum.UnsyncCouple,
                data: _timelinesFormat.join(',')));

    _response.fold((model) {
      if (model.isSuccess) {
        _userWrapper.setCoupleId(model.data);
      }

      emit(state.copyWith(
        isLoading: false,
        isError: !model.isSuccess,
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
