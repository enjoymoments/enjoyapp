import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mozin/features/ads/data/repositories/ads_banner_repository_impl.dart';
import 'package:mozin/features/ads/data/repositories/ads_publisher_banner_repository_impl.dart';
import 'package:mozin/features/ads/domain/repositories/ads_banner_repository.dart';
import 'package:mozin/features/ads/domain/repositories/ads_publisher_banner_repository.dart';
import 'package:mozin/features/ads/presentation/bloc/ads_cubit.dart';
import 'package:mozin/features/listener_manager/presentation/bloc/listener_manager_cubit.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/modules/config/injection/injection_bloc.dart';
import 'package:mozin/modules/config/injection/injection_data_source.dart';
import 'package:mozin/modules/config/injection/injection_model.dart';
import 'package:mozin/modules/config/injection/injection_repository.dart';
import 'package:mozin/modules/config/injection/injection_service.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/logger/service/logger_service.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:mozin_core/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

GetIt getItInstance = GetIt.instance;
GetIt root = GetIt.asNewInstance();

void setupRoot() {
  root.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(),
  );

  root.registerLazySingleton<ListenerManagerCubit>(
    () => ListenerManagerCubit(),
  );

  root.registerLazySingleton<AdsBannerRepository>(
    () => AdsBannerRepositoryImpl(),
  );

  root.registerLazySingleton<AdsPublisherBannerRepository>(
    () => AdsPublisherBannerRepositoryImpl(),
  );

  root.registerFactory<AdsCubit>(() => AdsCubit(
        adsBannerRepository: root<AdsBannerRepository>(),
        adsPublisherBannerRepository: root<AdsPublisherBannerRepository>(),
      ));
}

Future setup() async {
  getItInstance.allowReassignment = true;

  var localstorage = await _setupHive();
  getItInstance.registerSingleton(localstorage);

  var remoteConfig = await _setupFirebaseRemoteConfig();
  getItInstance.registerSingleton(remoteConfig);

  registerSingletonModels(getItInstance);
  registerSingletonServices(getItInstance);
  registerSingletonRepositories(getItInstance);
  registerSingletonDataSources(getItInstance);
  registerBlocs(getItInstance);

  _setupRemoteClientRepository();
}

Future<RemoteConfig> _setupFirebaseRemoteConfig() async {
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.setDefaults(getRemoteConfigDefault());
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}

void _setupRemoteClientRepository() {
  Dio _dio = Dio();
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  getItInstance.registerLazySingleton<RemoteClientRepository>(
      () => RemoteClientRepository(
            dio: _dio,
            url:
                //'http://enjoyapi.com.br/graphql/',
                //'https://localhost:5001/graphql',
            //'https://10.0.2.2:5001/graphql',
            getItInstance<RemoteConfig>().getString(url_endpoint),
            loggerService: getItInstance<LoggerService>(),
          ));
}

Future<LocalStorageService> _setupHive() async {
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final userBox = await Hive.openBox("user_box");
  return LocalStorageService(userBox);
}

Future<void> resetInstances() async {
  await getItInstance<LocalStorageService>().clearAll();
  await getItInstance<LocalStorageService>().put(KeyValue<String, String>(
        key: bypass_onboarding_screen, value: bypass_onboarding_screen));

  await root<ListenerManagerCubit>().unsubscribeActionListener();

  getItInstance.reset();

  await setup();
}
