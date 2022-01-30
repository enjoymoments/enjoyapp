import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_state.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoState.initial());

  Future<void> setUserInfo() async {
    emit(state.copyWith(isLoading: true));

    var response = await getItInstance<UserService>().setUserInfo();
    response.fold((model) {
      if (model != null) {
        getItInstance<UserWrapper>().setInternalId(model.userInternalId);
        getItInstance<UserWrapper>().setCoupleId(model.coupleId);

        emit(state.copyWith(
          isLoading: false,
          existCoupleId: model.coupleId != null,
          forceRefresh: StateUtils.generateRandomNumber() as int?,
        ));
      }
    }, (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    });
  }

  void isLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }
}
