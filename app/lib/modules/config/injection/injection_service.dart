import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/router_external_resolver.dart';
import 'package:mozin/modules/shared/firebase/analytics_service.dart';
import 'package:mozin/modules/shared/firebase/firebase_dynamic_links.dart';
import 'package:mozin/modules/shared/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:uuid/uuid.dart';

void registerSingletonServices(GetIt getItInstance) {
  getItInstance.registerLazySingleton<WrapperMediaService>(() =>
      WrapperMediaService(
          uuidService: getItInstance(),
          firebaseStorageService: getItInstance(),
          userWrapper: getItInstance()));
  getItInstance.registerLazySingleton<Uuid>(() => Uuid());
  getItInstance.registerLazySingleton<FirebaseStorageService>(
      () => FirebaseStorageService());
  getItInstance
      .registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());

  getItInstance
      .registerLazySingleton<UserService>(() => UserService(getItInstance()));

  getItInstance.registerLazySingleton<PushNotificationConfig>(
      () => PushNotificationConfig());

  getItInstance.registerLazySingleton<LoggerService>(() => LoggerService(
        loggerRepository: getItInstance(),
        deviceInfoService: getItInstance(),
      ));

  getItInstance
      .registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  getItInstance.registerLazySingleton<ShareService>(() => ShareService());

  getItInstance.registerLazySingleton<RouterExternalResolver>(
      () => RouterExternalResolver());

  getItInstance.registerLazySingleton<ConfigureFirebaseDynamicLinks>(
      () => ConfigureFirebaseDynamicLinks());
}
