import 'package:get_it/get_it.dart';
import 'package:mozin/features/albums/presentation/blocs/add_album/add_album_cubit.dart';
import 'package:mozin/features/albums/presentation/blocs/albums/albums_cubit.dart';
import 'package:mozin/features/albums/presentation/blocs/edit_album/edit_album_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/cubit/calendar_cubit.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_bloc.dart';
import 'package:mozin/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/features/me/presentation/blocs/connected/connected_cubit.dart';
import 'package:mozin/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:mozin/features/places/presentation/blocs/categories_places/categories_places_cubit.dart';
import 'package:mozin/features/places/presentation/blocs/categories_sections/categories_sections_cubit.dart';
import 'package:mozin/features/places/presentation/blocs/place_details/place_details_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_details_tab/place_details_tab_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/place_photos/place_photos_bloc.dart';
import 'package:mozin/features/places/presentation/blocs/places/places_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/unsync_couple/presentation/bloc/unsync_couple/unsynccouple_cubit.dart';
import 'package:mozin/features/user_action/presentation/bloc/user_action/user_action_cubit.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_cubit.dart';

void registerBlocs(GetIt getItInstance) {
  getItInstance
      .registerFactory<AddTimeLineBloc>(() => AddTimeLineBloc(getItInstance()));

  getItInstance.registerLazySingleton<TimelineBloc>(
      () => TimelineBloc(getItInstance()));

  getItInstance.registerLazySingleton<ScreenManagerBloc>(() =>
      ScreenManagerBloc(getItInstance(), getItInstance(), getItInstance(),
          getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<InterestBloc>(() => InterestBloc(
      interestRepository: getItInstance(),
      filterChoosedWrapper: getItInstance()));

  getItInstance.registerLazySingleton<PlacesBloc>(() => PlacesBloc(
      placesRepository: getItInstance(),
      filterChoosedWrapper: getItInstance()));

  getItInstance.registerFactory<PlaceDetailsBloc>(
      () => PlaceDetailsBloc(placesRepository: getItInstance()));

  getItInstance
      .registerFactory<PlaceDetailsTabBloc>(() => PlaceDetailsTabBloc());

  getItInstance.registerFactory<PlacePhotosBloc>(
      () => PlacePhotosBloc(placesRepository: getItInstance()));

  getItInstance.registerFactory<GpsOpenCubit>(() => GpsOpenCubit());

  getItInstance.registerFactory<ConnectedCubit>(() => ConnectedCubit());

  getItInstance.registerLazySingleton<FavoriteInterestsBloc>(() =>
      FavoriteInterestsBloc());

  getItInstance.registerFactory<FavoriteInterestsItemBloc>(() =>
      FavoriteInterestsItemBloc(favoriteInterestsRepository: getItInstance()));    

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

  getItInstance.registerFactory<EditAlbumCubit>(() => EditAlbumCubit(
      wrapperMediaService: getItInstance(),
      albumsRepository: getItInstance(),
      userWrapper: getItInstance()));

  getItInstance.registerFactory<FeedbackCubit>(() => FeedbackCubit(
      feedbackRepository: getItInstance(), userWrapper: getItInstance()));

  getItInstance.registerLazySingleton<InviteCubit>(() => InviteCubit(
      inviteRepository: getItInstance(),
      userWrapper: getItInstance(),
      shareService: getItInstance(),
      userActionRepository: getItInstance()));

  getItInstance.registerLazySingleton<UserActionCubit>(
      () => UserActionCubit(userActionRepository: getItInstance()));

  getItInstance.registerLazySingleton<NotificationsCubit>(
      () => NotificationsCubit(notificationsRepository: getItInstance()));

  getItInstance.registerLazySingleton<UserInfoCubit>(() => UserInfoCubit());

  getItInstance.registerFactory<UnsyncCoupleCubit>(
      () => UnsyncCoupleCubit(userActionRepository: getItInstance()));

  getItInstance.registerFactory<SuggestionsCubit>(() => SuggestionsCubit(
      suggestionsRepository: getItInstance<SuggestionsRepository>()));

  getItInstance.registerFactory<CategoriesSectionsCubit>(() => CategoriesSectionsCubit());
}