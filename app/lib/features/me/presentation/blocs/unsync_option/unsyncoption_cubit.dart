import 'package:bloc/bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'unsyncoption_state.dart';

class UnsyncOptionCubit extends Cubit<UnsyncOptionState> {
  UnsyncOptionCubit() : super(UnsyncOptionState.initial());

  void existCoupleId() async {
    var _userWrapper = getItInstance<UserWrapper>();
    var _coupleId = await _userWrapper.getCoupleId();

    emit(state.copyWith(existCoupleId: _coupleId != null));
  }
}
