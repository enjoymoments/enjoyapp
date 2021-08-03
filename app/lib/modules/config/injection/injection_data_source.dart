import 'package:get_it/get_it.dart';
import 'package:mozin/features/albums/data/datasources/albums_remote_data_source.dart';
import 'package:mozin/features/calendar/data/datasources/activity_remote_data_source.dart';
import 'package:mozin/features/calendar/data/datasources/calendar_remote_data_source.dart';
import 'package:mozin/features/favoriteinterests/data/datasources/favorite_interests_remote_data_source.dart';
import 'package:mozin/features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'package:mozin/features/interest/data/datasources/interest_remote_data_source.dart';
import 'package:mozin/features/invite/data/datasources/invite_remote_data_source.dart';
import 'package:mozin/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:mozin/features/places/data/datasources/places_remote_data_source.dart';
import 'package:mozin/features/suggestions/data/datasources/suggestions_remote_data_source.dart';
import 'package:mozin/features/time_line/data/datasources/time_line_remote_data_source.dart';
import 'package:mozin/features/user_action/data/datasources/user_action_remote_data_source.dart';
import 'package:mozin/modules/shared/user/datasources/user_remote_data_source.dart';

void registerSingletonDataSources(GetIt getItInstance) {
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

  getItInstance.registerLazySingleton<InviteRemoteDataSource>(() =>
      InviteRemoteDataSourceImpl(
          remoteClientRepository: getItInstance(),
          remoteConfig: getItInstance()));

  getItInstance.registerLazySingleton<UserActionRemoteDataSource>(
      () => UserActionRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<SuggestionsRemoteDataSource>(
      () => SuggestionsRemoteDataSourceImpl(getItInstance()));
}