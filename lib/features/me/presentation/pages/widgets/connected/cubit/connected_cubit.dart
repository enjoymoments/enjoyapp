import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected_tab_enum.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  ConnectedCubit() : super(ConnectedState.initial());

  void changeTab(int nextTab) {
    var _favoriteInterests;

    if (ConnectedTabEnum.values[nextTab] == ConnectedTabEnum.PLACE) {
      var _userWrapper = getItInstance<UserWrapper>();
      var _user = _userWrapper.getUser;
      _favoriteInterests = _user.favoriteInterests;
    }

    emit(state.copyWith(
      connectedTabEnum: ConnectedTabEnum.values[nextTab],
      favoriteInterests: _favoriteInterests,
    ));
  }
}
