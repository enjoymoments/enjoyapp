import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mozin/features/ads/data/repositories/ads_repository_impl.dart';
import 'package:mozin/features/ads/domain/repositories/ads_repository.dart';
import 'package:mozin/features/ads/presentation/bloc/ads_cubit.dart';
import 'package:mozin/features/albums/data/datasources/albums_remote_data_source.dart';
import 'package:mozin/features/albums/data/repositories/albums_repository_impl.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/features/albums/presentation/blocs/add_album/add_album_cubit.dart';
import 'package:mozin/features/albums/presentation/blocs/albums/albums_cubit.dart';
import 'package:mozin/features/calendar/data/datasources/activity_remote_data_source.dart';
import 'package:mozin/features/calendar/data/datasources/calendar_remote_data_source.dart';
import 'package:mozin/features/calendar/data/repositories/activity_repository_impl.dart';
import 'package:mozin/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:mozin/features/calendar/domain/repositories/activity_repository.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/cubit/calendar_cubit.dart';
import 'package:mozin/features/favoriteinterests/data/datasources/favorite_interests_remote_data_source.dart';
import 'package:mozin/features/favoriteinterests/data/repositories/favorite_interests_repository_impl.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:mozin/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:mozin/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:mozin/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:mozin/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:mozin/features/interest/data/datasources/interest_remote_data_source.dart';
import 'package:mozin/features/interest/data/repositories/interest_repository_impl.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:mozin/features/invite/data/datasources/invite_remote_data_source.dart';
import 'package:mozin/features/invite/data/repositories/invite_repository_impl.dart';
import 'package:mozin/features/invite/domain/repositories/invite_repository.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/features/me/presentation/blocs/connected/connected_cubit.dart';
import 'package:mozin/features/me/presentation/blocs/unsync_option/unsyncoption_cubit.dart';
import 'package:mozin/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:mozin/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mozin/features/notifications/presentation/bloc/notifications_cubit.dart';
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
import 'package:mozin/features/unsync_couple/presentation/bloc/unsync_couple/unsynccouple_cubit.dart';
import 'package:mozin/features/user_action/data/datasources/user_action_remote_data_source.dart';
import 'package:mozin/features/user_action/data/repositories/user_action_repository_impl.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/features/user_action/presentation/bloc/user_action/user_action_cubit.dart';
import 'package:mozin/modules/config/router_external_resolver.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:mozin/modules/shared/firebase/analytics_service.dart';
import 'package:mozin/modules/shared/firebase/firebase_dynamic_links.dart';
import 'package:mozin/modules/shared/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/general/services/share_service.dart';
import 'package:mozin/modules/shared/logger/repository/logger_repository.dart';
import 'package:mozin/modules/shared/logger/service/logger_service.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';
import 'package:mozin/modules/shared/general/services/device_info_service.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/shared/general/services/wrapper_media_service.dart';
import 'package:mozin/modules/shared/user/datasources/user_remote_data_source.dart';
import 'package:mozin/modules/shared/user/repositories/user_repository.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/remote_config.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

GetIt getItInstance = GetIt.instance;
GetIt root = GetIt.asNewInstance();

void setupRoot() {
  root.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(),
  );

  root.registerLazySingleton<AdsRepository>(
    () => AdsRepositoryImpl(),
  );
}

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

void _registerSingletonModels() {
  getItInstance.registerSingleton<UserWrapper>(
      UserWrapper(localStorageService: getItInstance())..assignment(UserAppModel.empty));
  getItInstance.registerSingleton(FilterChoosedWrapper(
    localStorageService: getItInstance(),
  )..init());
}

void _registerSingletonServices() {
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
      userWrapper: getItInstance()));

  getItInstance
      .registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  getItInstance
      .registerLazySingleton<ShareService>(() => ShareService());

  getItInstance
      .registerLazySingleton<RouterExternalResolver>(() => RouterExternalResolver());    

  getItInstance
      .registerLazySingleton<ConfigureFirebaseDynamicLinks>(() => ConfigureFirebaseDynamicLinks());        
}

void _registerBlocs() {
  getItInstance
      .registerFactory<AddTimeLineBloc>(() => AddTimeLineBloc(getItInstance()));

  getItInstance.registerLazySingleton<TimelineBloc>(
      () => TimelineBloc(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<ScreenManagerBloc>(() =>
      ScreenManagerBloc(getItInstance(), getItInstance(), getItInstance(),
          getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<InterestBloc>(() => InterestBloc(
      interestRepository: getItInstance(),
      filterChoosedWrapper: getItInstance()));

  getItInstance.registerLazySingleton<PlacesBloc>(
      () => PlacesBloc(placesRepository: getItInstance(), filterChoosedWrapper: getItInstance()));

  getItInstance.registerFactory<IntroBloc>(() => IntroBloc(getItInstance()));

  getItInstance.registerFactory<PlaceDetailsBloc>(
      () => PlaceDetailsBloc(placesRepository: getItInstance()));

  getItInstance
      .registerFactory<PlaceDetailsTabBloc>(() => PlaceDetailsTabBloc());

  getItInstance.registerFactory<PlacePhotosBloc>(
      () => PlacePhotosBloc(placesRepository: getItInstance()));

  getItInstance.registerFactory<GpsOpenCubit>(() => GpsOpenCubit());

  getItInstance.registerFactory<ConnectedCubit>(
      () => ConnectedCubit());

  getItInstance.registerFactory<FavoriteInterestsBloc>(() =>
      FavoriteInterestsBloc(favoriteInterestsRepository: getItInstance()));

  getItInstance
      .registerFactory<CategoriesPlacesCubit>(() => CategoriesPlacesCubit());

  getItInstance.registerFactory<AddCalendarCubit>(
      () => AddCalendarCubit(calendarRepository: getItInstance()));

  getItInstance.registerFactory<AddActivityCubit>(
      () => AddActivityCubit(activityRepository: getItInstance()));

  getItInstance.registerLazySingleton<CalendarCubit>(
      () => CalendarCubit(calendarRepository: getItInstance()));

  getItInstance.registerFactory<AlbumsCubit>(() => AlbumsCubit(
      albumsRepository: getItInstance(), userWrapper: getItInstance()));

  getItInstance.registerFactory<AddAlbumCubit>(
      () => AddAlbumCubit(wrapperMediaService: getItInstance()));

  getItInstance.registerFactory<FeedbackCubit>(() => FeedbackCubit(
      feedbackRepository: getItInstance(), userWrapper: getItInstance()));

  getItInstance.registerFactory<HomeCubit>(
      () => HomeCubit());

  getItInstance.registerFactory<AdsCubit>(
      () => AdsCubit(adsRepository: root<AdsRepository>()));

  getItInstance.registerLazySingleton<InviteCubit>(
      () => InviteCubit(inviteRepository: getItInstance(), userWrapper: getItInstance(), shareService: getItInstance(), userActionRepository: getItInstance()));

  getItInstance.registerLazySingleton<UserActionCubit>(() => UserActionCubit(userActionRepository: getItInstance()));

  getItInstance.registerLazySingleton<NotificationsCubit>(() => NotificationsCubit(notificationsRepository: getItInstance())); 

  getItInstance.registerFactory<UnsyncOptionCubit>(
      () => UnsyncOptionCubit());

  getItInstance.registerFactory<UnsyncCoupleCubit>(
      () => UnsyncCoupleCubit());    
}

void _registerSingletonRepositories() {
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(loggerService: getItInstance()));

  getItInstance.registerLazySingleton<TimelineRepository>(
      () => TimelineRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<UserRepository>(
      () => UserRepository(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<LoggerRepository>(
      () => LoggerRepository(remoteConfig: getItInstance()));

  getItInstance.registerLazySingleton<InterestRepository>(
      () => InterestRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<PlacesRepository>(
      () => PlacesRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<FavoriteInterestsRepository>(
      () => FavoriteInterestsRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<CalendarRepository>(
      () => CalendarRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<AlbumsRepository>(
      () => AlbumsRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<InviteRepository>(
      () => InviteRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<UserActionRepository>(
      () => UserActionRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(remoteDataSource: getItInstance()));
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

  getItInstance.registerLazySingleton<CalendarRemoteDataSource>(
      () => CalendarRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<ActivityRemoteDataSource>(
      () => ActivityRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AlbumsRemoteDataSource>(
      () => AlbumsRemoteDataSourceImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<FeedbackRemoteDataSource>(
      () => FeedbackRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<InviteRemoteDataSource>(
      () => InviteRemoteDataSourceImpl(remoteClientRepository: getItInstance(), remoteConfig: getItInstance()));

  getItInstance.registerLazySingleton<UserActionRemoteDataSource>(
      () => UserActionRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(getItInstance()));
}

Future<LocalStorageService> _setupHive() async {
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final userBox = await Hive.openBox("user_box");
  return LocalStorageService(userBox);
}

Future<void> resetInstances() async {
  await getItInstance<LocalStorageService>().clearAll();
  getItInstance<ScreenManagerBloc>()..add(UnsubscribeActionListener());
  
  getItInstance.reset();

  await setup();
}
