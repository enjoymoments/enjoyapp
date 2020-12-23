import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/connected_tab_enum.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  ConnectedCubit() : super(ConnectedState.initial());

  void changeTab(int nextTab) {
    emit(state.copyWith(connectedTabEnum: ConnectedTabEnum.values[nextTab]));
  }
}
