// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/albums/data/models/album_item_model.dart';
import '../../features/albums/presentation/pages/add_albums_screen.dart';
import '../../features/albums/presentation/pages/albums_screen.dart';
import '../../features/calendar/data/models/task_calendar_model.dart';
import '../../features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart';
import '../../features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import '../../features/calendar/presentation/pages/add_activity_screen.dart';
import '../../features/calendar/presentation/pages/add_calendar_screen.dart';
import '../../features/calendar/presentation/pages/calendar_screen.dart';
import '../../features/configuration/presentation/pages/configuration_screen.dart';
import '../../features/favoriteinterests/presentation/pages/favorite_interests_screen.dart';
import '../../features/feedback/presentation/pages/feedback_screen.dart';
import '../../features/interest/presentation/pages/interest_screen.dart';
import '../../features/intro/presentation/pages/intro_screen.dart';
import '../../features/notifications/presentation/pages/notifications_screen.dart';
import '../../features/places/data/models/place_model.dart';
import '../../features/places/presentation/pages/place_item_details.dart';
import '../../features/places/presentation/pages/search_places_screen.dart';
import '../../features/screen_manager/presentation/screen_manager.dart';
import '../../features/time_line/presentation/pages/add_time_line_screen.dart';
import '../../package_view/custom_success_screen.dart';
import '../../package_view/gallery_images/gallery_photo_source_type_enum.dart';
import '../../package_view/gallery_images/gallery_photo_view_wrapper.dart';
import '../../package_view/onboading_screen.dart';
import '../shared/general/models/gallery_image_model.dart';
import 'router.dart';

class Routes {
  static const String intro_screen = '/';
  static const String screen_manager_screen = '/screen-manager';
  static const String onboarding_screen = '/on-boarding-screen';
  static const String search_places_screen = '/search-places-screen';
  static const String place_item_details_screen = '/place-item-details';
  static const String interest_screen = '/interest-screen';
  static const String add_time_line_screen = '/add-time-line-screen';
  static const String gallery_photo_view_wrapper_screen =
      '/gallery-photo-view-wrapper';
  static const String notification_screen = '/notifications-screen';
  static const String favorite_interests_screen = '/favorite-interests-screen';
  static const String calendar_screen = '/calendar-screen';
  static const String add_calendar_screen = '/add-calendar-screen';
  static const String add_activity_screen = '/add-activity-screen';
  static const String feedback_screen = '/feedback-screen';
  static const String albums_screen = '/albums-screen';
  static const String add_albums_screen = '/add-albums-screen';
  static const String success_screen = '/custom-success-screen';
  static const String configuration_screen = '/configuration-screen';
  static const String home_partial = '/home-partial';
  static const String me_authenticated_partial = '/me-authenticated-partial';
  static const all = <String>{
    intro_screen,
    screen_manager_screen,
    onboarding_screen,
    search_places_screen,
    place_item_details_screen,
    interest_screen,
    add_time_line_screen,
    gallery_photo_view_wrapper_screen,
    notification_screen,
    favorite_interests_screen,
    calendar_screen,
    add_calendar_screen,
    add_activity_screen,
    feedback_screen,
    albums_screen,
    add_albums_screen,
    success_screen,
    configuration_screen,
    home_partial,
    me_authenticated_partial,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.intro_screen, page: IntroScreen),
    RouteDef(Routes.screen_manager_screen, page: ScreenManager),
    RouteDef(Routes.onboarding_screen, page: OnBoardingScreen),
    RouteDef(Routes.search_places_screen, page: SearchPlacesScreen),
    RouteDef(Routes.place_item_details_screen, page: PlaceItemDetails),
    RouteDef(Routes.interest_screen, page: InterestScreen),
    RouteDef(Routes.add_time_line_screen, page: AddTimeLineScreen),
    RouteDef(Routes.gallery_photo_view_wrapper_screen,
        page: GalleryPhotoViewWrapper),
    RouteDef(Routes.notification_screen, page: NotificationsScreen),
    RouteDef(Routes.favorite_interests_screen, page: FavoriteInterestsScreen),
    RouteDef(Routes.calendar_screen, page: CalendarScreen),
    RouteDef(Routes.add_calendar_screen, page: AddCalendarScreen),
    RouteDef(Routes.add_activity_screen, page: AddActivityScreen),
    RouteDef(Routes.feedback_screen, page: FeedbackScreen),
    RouteDef(Routes.albums_screen, page: AlbumsScreen),
    RouteDef(Routes.add_albums_screen, page: AddAlbumsScreen),
    RouteDef(Routes.success_screen, page: CustomSuccessScreen),
    RouteDef(Routes.configuration_screen, page: ConfigurationScreen),
    RouteDef(Routes.home_partial, page: HomePartial),
    RouteDef(Routes.me_authenticated_partial, page: MeAuthenticatedPartial),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    IntroScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => IntroScreen(),
        settings: data,
      );
    },
    ScreenManager: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScreenManager(),
        settings: data,
      );
    },
    OnBoardingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingScreen(),
        settings: data,
      );
    },
    SearchPlacesScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchPlacesScreen(),
        settings: data,
      );
    },
    PlaceItemDetails: (data) {
      final args = data.getArgs<PlaceItemDetailsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PlaceItemDetails(
          key: args.key,
          item: args.item,
        ),
        settings: data,
      );
    },
    InterestScreen: (data) {
      final args = data.getArgs<InterestScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => InterestScreen(
          key: args.key,
          isChangeFilter: args.isChangeFilter,
        ),
        settings: data,
      );
    },
    AddTimeLineScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddTimeLineScreen(),
        settings: data,
      );
    },
    GalleryPhotoViewWrapper: (data) {
      final args =
          data.getArgs<GalleryPhotoViewWrapperArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => GalleryPhotoViewWrapper(
          loadingBuilder: args.loadingBuilder,
          backgroundDecoration: args.backgroundDecoration,
          minScale: args.minScale,
          maxScale: args.maxScale,
          initialIndex: args.initialIndex,
          galleryItems: args.galleryItems,
          galleryPhotoSourceType: args.galleryPhotoSourceType,
          scrollDirection: args.scrollDirection,
        ),
        settings: data,
      );
    },
    NotificationsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NotificationsScreen(),
        settings: data,
      );
    },
    FavoriteInterestsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FavoriteInterestsScreen(),
        settings: data,
      );
    },
    CalendarScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CalendarScreen(),
        settings: data,
      );
    },
    AddCalendarScreen: (data) {
      final args = data.getArgs<AddCalendarScreenArguments>(
        orElse: () => AddCalendarScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddCalendarScreen(
          key: args.key,
          taskModel: args.taskModel,
        ),
        settings: data,
      );
    },
    AddActivityScreen: (data) {
      final args = data.getArgs<AddActivityScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddActivityScreen(
          key: args.key,
          activityCubit: args.activityCubit,
          addCalendarCubit: args.addCalendarCubit,
        ),
        settings: data,
      );
    },
    FeedbackScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FeedbackScreen(),
        settings: data,
      );
    },
    AlbumsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AlbumsScreen(),
        settings: data,
      );
    },
    AddAlbumsScreen: (data) {
      final args = data.getArgs<AddAlbumsScreenArguments>(
        orElse: () => AddAlbumsScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddAlbumsScreen(
          key: args.key,
          album: args.album,
        ),
        settings: data,
      );
    },
    CustomSuccessScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CustomSuccessScreen(),
        settings: data,
      );
    },
    ConfigurationScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ConfigurationScreen(),
        settings: data,
      );
    },
    HomePartial: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePartial(),
        settings: data,
      );
    },
    MeAuthenticatedPartial: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MeAuthenticatedPartial(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PlaceItemDetails arguments holder class
class PlaceItemDetailsArguments {
  final Key key;
  final PlaceModel item;
  PlaceItemDetailsArguments({this.key, @required this.item});
}

/// InterestScreen arguments holder class
class InterestScreenArguments {
  final Key key;
  final bool isChangeFilter;
  InterestScreenArguments({this.key, @required this.isChangeFilter});
}

/// GalleryPhotoViewWrapper arguments holder class
class GalleryPhotoViewWrapperArguments {
  final Widget Function(BuildContext, ImageChunkEvent) loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final List<GalleryImageModel> galleryItems;
  final GalleryPhotoSourceTypeEnum galleryPhotoSourceType;
  final Axis scrollDirection;
  GalleryPhotoViewWrapperArguments(
      {this.loadingBuilder,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex,
      @required this.galleryItems,
      @required this.galleryPhotoSourceType,
      this.scrollDirection = Axis.horizontal});
}

/// AddCalendarScreen arguments holder class
class AddCalendarScreenArguments {
  final Key key;
  final TaskCalendarModel taskModel;
  AddCalendarScreenArguments({this.key, this.taskModel});
}

/// AddActivityScreen arguments holder class
class AddActivityScreenArguments {
  final Key key;
  final AddActivityCubit activityCubit;
  final AddCalendarCubit addCalendarCubit;
  AddActivityScreenArguments(
      {this.key,
      @required this.activityCubit,
      @required this.addCalendarCubit});
}

/// AddAlbumsScreen arguments holder class
class AddAlbumsScreenArguments {
  final Key key;
  final AlbumItemModel album;
  AddAlbumsScreenArguments({this.key, this.album});
}
