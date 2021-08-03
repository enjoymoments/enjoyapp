import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'user_action_state.dart';

class UserActionCubit extends Cubit<UserActionState> {
  UserActionCubit({
    @required UserActionRepository userActionRepository,
  })  : assert(userActionRepository != null),
        _userActionRepository = userActionRepository,
        super(UserActionState.initial());

  final UserActionRepository _userActionRepository;
}
