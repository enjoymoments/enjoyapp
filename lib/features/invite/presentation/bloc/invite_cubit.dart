import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/invite/domain/repositories/invite_repository.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
import 'package:mozin/package_view/utils.dart';

part 'invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  InviteCubit({
    @required InviteRepository inviteRepository,
    @required UserWrapper userWrapper,
  })  : assert(userWrapper != null),
        _userWrapper = userWrapper,
        assert(inviteRepository != null),
        _inviteRepository = inviteRepository,
        super(InviteState.initial());

  final InviteRepository _inviteRepository;
  final UserWrapper _userWrapper;

  void generateShareUrl() async {
    emit(state.copyWith(isLoading: true));
    var _user = _userWrapper.getUser;
    //TODO:share review this
    //var response = await _inviteRepository.generateShareUrl(_user.internalId);
    var response = await _inviteRepository.generateShareUrl('6076373d4d0050bd520ba74b'); 

    response.fold((model) {
      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        shareUrl: model,
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
    }, (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
        forceRefresh: StateUtils.generateRandomNumber(),
      ));
    });
  }
}
