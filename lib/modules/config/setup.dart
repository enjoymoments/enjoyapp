import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mozin/features/calendar/presentation/cubit/add_calendar_cubit.dart';
import 'package:mozin/features/favoriteinterests/data/datasources/favorite_interests_remote_data_source.dart';
import 'package:mozin/features/favoriteinterests/data/repositories/favorite_interests_repository_impl.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/interest/data/datasources/interest_remote_data_source.dart';
import 'package:mozin/features/interest/data/repositories/interest_repository_impl.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:mozin/features/me/presentation/pages/widgets/connected/cubit/connected_cubit.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/bloc/authentication_bloc.dart';
import 'package:mozin/features/places/data/datasources/places_remote_data_source.dart';
import 'package:mozin/features/places/data/repositories/places_repository_impl.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/features/places/presentation/blocs/place_details/place_details_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_photos/place_photos_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/places/places_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/cubit/categories_places_cubit.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/features/time_line/data/datasources/time_line_remote_data_source.dart';
import 'package:mozin/features/time_line/data/repositories/time_line_repository_impl.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
import 'package:mozin/modules/shared/firebase/analytics_service.dart';
import 'package:mozin/modules/shared/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/logger/repository/logger_repository.dart';
import 'package:mozin/modules/shared/logger/service/logger_service.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';
import 'package:mozin/modules/shared/general/services/device_info_service.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/modules/shared/user/repositories/user_repository.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

GetIt getItInstance = GetIt.instance;

Future setup() async {
  getItInstance.allowReassignment = true;

  var localstorage = await _setupHive();
  getItInstance.registerSingleton(localstorage);

  var remoteConfig = await _setupFirebaseRemoteConfig();
  getItInstance.registerSingleton(remoteConfig);

  _registerSingletonModels();
  _registerSingletonServices();
  _registerSingletonRepositories();
  _registerSingletonDataSources();
  _registerBlocs();

  _setupRemoteClientRepository();
}

Future<RemoteConfig> _setupFirebaseRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  await remoteConfig.setDefaults(getRemoteConfigDefault());
  await remoteConfig.fetch();
  await remoteConfig.activateFetched();
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
                //'https://localhost:5001/graphql',
                //'https://10.0.2.2:5001/graphql',
                getItInstance<RemoteConfig>().getString(url_endpoint),
            loggerService: getItInstance<LoggerService>(),
          ));
}

void _registerSingletonModels() {
  getItInstance.registerSingleton<UserWrapper>(
      UserWrapper()..assignment(UserAppModel.empty));
  getItInstance.registerSingleton(
      FilterChoosedWrapper()..assignment(FilterChoosedModel.initial()));
}

void _registerSingletonServices() {
  getItInstance
      .registerLazySingleton<WrapperMediaService>(() => WrapperMediaService());
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
      userWrapper: getItInstance()));

  getItInstance
      .registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}

void _registerBlocs() {
  getItInstance.registerFactory<AddTimeLineBloc>(
      () => AddTimeLineBloc(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationBloc>(() =>
      AuthenticationBloc(
          getItInstance(), getItInstance(), getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<TimelineBloc>(
      () => TimelineBloc(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<ScreenManagerBloc>(() =>
      ScreenManagerBloc(
          getItInstance(), getItInstance(), getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<InterestBloc>(() => InterestBloc(
      interestRepository: getItInstance(),
      filterChoosedWrapper: getItInstance()));

  getItInstance.registerLazySingleton<PlacesBloc>(
      () => PlacesBloc(placesRepository: getItInstance()));

  getItInstance.registerFactory<IntroBloc>(() => IntroBloc(getItInstance()));

  getItInstance.registerFactory<PlaceDetailsBloc>(
      () => PlaceDetailsBloc(placesRepository: getItInstance()));
      
  getItInstance
      .registerFactory<PlaceDetailsTabBloc>(() => PlaceDetailsTabBloc());

  getItInstance.registerFactory<PlacePhotosBloc>(
      () => PlacePhotosBloc(placesRepository: getItInstance()));

  getItInstance.registerFactory<GpsOpenCubit>(
      () => GpsOpenCubit());    

  getItInstance.registerFactory<ConnectedCubit>(
      () => ConnectedCubit());    

  getItInstance.registerFactory<FavoriteInterestsBloc>(
      () => FavoriteInterestsBloc(favoriteInterestsRepository: getItInstance()));    

  getItInstance.registerFactory<CategoriesPlacesCubit>(
      () => CategoriesPlacesCubit());        

  getItInstance.registerFactory<AddCalendarCubit>(
      () => AddCalendarCubit());        
}

void _registerSingletonRepositories() {
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  getItInstance.registerLazySingleton<TimelineRepository>(
      () => TimelineRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<UserRepository>(() => UserRepository());

  getItInstance.registerLazySingleton<LoggerRepository>(
      () => LoggerRepository(remoteConfig: getItInstance()));

  getItInstance.registerLazySingleton<InterestRepository>(
      () => InterestRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<PlacesRepository>(
      () => PlacesRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<FavoriteInterestsRepository>(
      () => FavoriteInterestsRepositoryImpl(remoteDataSource: getItInstance())); 
}

void _registerSingletonDataSources() {
  getItInstance.registerLazySingleton<TimelineRemoteDataSource>(
      () => TimelineRemoteDataSourceImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<InterestRemoteDataSource>(
      () => InterestRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<PlacesRemoteDataSource>(
      () => PlacesRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<FavoriteInterestsRemoteDataSource>(
      () => FavoriteInterestsRemoteDataSourceImpl(getItInstance()));    
}

Future<LocalStorageService> _setupHive() async {
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final userBox = await Hive.openBox("user_box");
  return LocalStorageService(userBox);
}

Future<void> resetInstances() async {
  getItInstance.reset();

  await setup();
}
