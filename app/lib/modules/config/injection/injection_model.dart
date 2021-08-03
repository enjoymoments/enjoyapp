import 'package:get_it/get_it.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

void registerSingletonModels(GetIt getItInstance) {
  getItInstance.registerSingleton<UserWrapper>(
      UserWrapper(localStorageService: getItInstance())
        ..assignment(UserAppModel.empty));
  getItInstance.registerSingleton(FilterChoosedWrapper(
    localStorageService: getItInstance(),
  )..init());
}