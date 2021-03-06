import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/features/calendar/data/models/calendar_content_model.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

void registerSingletonModels(GetIt getItInstance) {
  getItInstance.registerSingleton<UserWrapper>(
      UserWrapper(localStorageService: getItInstance())
        ..assignment(UserAppModel.initial()));
  getItInstance.registerSingleton(FilterChoosedWrapper(
    localStorageService: getItInstance(),
  )..init());

  getItInstance.registerSingleton(CalendarContentModel.initial());
}
