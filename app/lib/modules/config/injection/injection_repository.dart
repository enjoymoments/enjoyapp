import 'package:custom_utilities/custom_utilities.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:mozin/features/albums/data/repositories/albums_repository_impl.dart';
import 'package:mozin/features/albums/domain/repositories/albums_repository.dart';
import 'package:mozin/features/calendar/data/repositories/activity_repository_impl.dart';
import 'package:mozin/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:mozin/features/calendar/domain/repositories/activity_repository.dart';
import 'package:mozin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:mozin/features/favoriteinterests/data/repositories/favorite_interests_repository_impl.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:mozin/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:mozin/features/interest/data/repositories/interest_repository_impl.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/features/invite/data/repositories/invite_repository_impl.dart';
import 'package:mozin/features/invite/domain/repositories/invite_repository.dart';
import 'package:mozin/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mozin/features/places/data/repositories/places_repository_impl.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/features/suggestions/data/repositories/suggestions_repository_impl.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:mozin/features/time_line/data/repositories/time_line_repository_impl.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/features/user_action/data/repositories/user_action_repository_impl.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/user/repositories/user_repository.dart';

import '../remote_config.dart';

void registerSingletonRepositories(GetIt getItInstance) {
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(loggerService: getItInstance()));

  getItInstance.registerLazySingleton<TimelineRepository>(
      () => TimelineRepositoryImpl(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<UserRepository>(
      () => UserRepository(remoteDataSource: getItInstance()));

  getItInstance.registerLazySingleton<LoggerRepository>(() => LoggerRepository(
      baseUrl: getItInstance<RemoteConfig>().getString(url_endpoint)));

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

  getItInstance.registerLazySingleton<SuggestionsRepository>(
      () => SuggestionsRepositoryImpl(remoteDataSource: getItInstance()));
}
