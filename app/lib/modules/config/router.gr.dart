// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:custom_view/custom_success_screen.dart' as _i19;
import 'package:flutter/material.dart' as _i2;

import '../../authentication_wrapper.dart' as _i3;
import '../../features/albums/data/models/album_item_model.dart' as _i32;
import '../../features/albums/presentation/pages/add_album_screen.dart' as _i17;
import '../../features/albums/presentation/pages/albums_screen.dart' as _i16;
import '../../features/albums/presentation/pages/edit_album_screen.dart'
    as _i18;
import '../../features/calendar/data/models/task_calendar_model.dart' as _i29;
import '../../features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart'
    as _i30;
import '../../features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart'
    as _i31;
import '../../features/calendar/presentation/pages/add_activity_screen.dart'
    as _i14;
import '../../features/calendar/presentation/pages/add_calendar_screen.dart'
    as _i13;
import '../../features/configuration/presentation/pages/configuration_screen.dart'
    as _i20;
import '../../features/favoriteinterests/presentation/pages/favorite_interests_screen.dart'
    as _i12;
import '../../features/feedback/presentation/pages/feedback_screen.dart'
    as _i15;
import '../../features/interest/presentation/pages/interest_screen.dart' as _i8;
import '../../features/invite/presentation/bloc/invite_cubit.dart' as _i33;
import '../../features/invite/presentation/pages/invite_screen.dart' as _i22;
import '../../features/me/presentation/pages/widgets/login/login_wrapper_screen.dart'
    as _i25;
import '../../features/notifications/presentation/pages/notifications_screen.dart'
    as _i11;
import '../../features/places/data/models/place_model.dart' as _i26;
import '../../features/places/presentation/pages/place_item_details.dart'
    as _i7;
import '../../features/places/presentation/pages/search_places_screen.dart'
    as _i6;
import '../../features/screen_manager/presentation/root_screen_manager.dart'
    as _i4;
import '../../features/suggestions/presentation/pages/add_suggestion_screen.dart'
    as _i24;
import '../../features/time_line/presentation/pages/add_time_line_screen.dart'
    as _i9;
import '../../features/unsync_couple/presentation/pages/unsync_couple_screen.dart'
    as _i23;
import '../shared/custom_view_migrate/gallery_images/gallery_photo_source_type_enum.dart'
    as _i28;
import '../shared/custom_view_migrate/gallery_images/gallery_photo_view_wrapper.dart'
    as _i10;
import '../shared/custom_view_migrate/onboading_screen.dart' as _i5;
import '../shared/general/models/gallery_image_model.dart' as _i27;
import 'router.dart' as _i21;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    Authentication_wrapper_screen.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (_) {
              return const _i3.AuthenticationWrapper();
            }),
    Root_screen_manager_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.RootScreenManager();
        }),
    Onboarding_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.OnBoardingScreen();
        }),
    Search_places_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.SearchPlacesScreen();
        }),
    Place_item_details_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Place_item_details_screenArgs>();
          return _i7.PlaceItemDetails(key: args.key, item: args.item);
        }),
    Interest_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Interest_screenArgs>();
          return _i8.InterestScreen(
              key: args.key, isChangeFilter: args.isChangeFilter);
        }),
    Add_time_line_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.AddTimeLineScreen();
        }),
    Gallery_photo_view_wrapper_screen.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<Gallery_photo_view_wrapper_screenArgs>();
              return _i10.GalleryPhotoViewWrapper(
                  loadingBuilder: args.loadingBuilder,
                  backgroundDecoration: args.backgroundDecoration,
                  minScale: args.minScale,
                  maxScale: args.maxScale,
                  initialIndex: args.initialIndex,
                  galleryItems: args.galleryItems,
                  galleryPhotoSourceType: args.galleryPhotoSourceType,
                  scrollDirection: args.scrollDirection);
            }),
    Notification_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.NotificationsScreen();
        }),
    Favorite_interests_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.FavoriteInterestsScreen();
        }),
    Add_calendar_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Add_calendar_screenArgs>(
              orElse: () => const Add_calendar_screenArgs());
          return _i13.AddCalendarScreen(
              key: args.key, taskModel: args.taskModel);
        }),
    Add_activity_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Add_activity_screenArgs>();
          return _i14.AddActivityScreen(
              key: args.key,
              activityCubit: args.activityCubit,
              addCalendarCubit: args.addCalendarCubit);
        }),
    Feedback_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i15.FeedbackScreen();
        }),
    Albums_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i16.AlbumsScreen();
        }),
    Add_albums_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i17.AddAlbumScreen();
        }),
    Edit_albums_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Edit_albums_screenArgs>();
          return _i18.EditAlbumScreen(key: args.key, album: args.album);
        }),
    Success_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Success_screenArgs>();
          return _i19.CustomSuccessScreen(key: args.key, child: args.child);
        }),
    Configuration_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i20.ConfigurationScreen();
        }),
    Home_partial.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i21.HomePartial();
        }),
    Me_authenticated_partial.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i21.MeAuthenticatedPartial();
        }),
    Invite_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<Invite_screenArgs>();
          return _i22.InviteScreen(
              key: args.key, inviteCubit: args.inviteCubit);
        }),
    Unsync_couple_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i23.UnsyncCoupleScreen();
        }),
    Add_suggestions_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i24.AddSuggestionScreen();
        }),
    Login_wrapper_screen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i25.LoginWrapperScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(Authentication_wrapper_screen.name, path: '/'),
        _i1.RouteConfig(Root_screen_manager_screen.name,
            path: '/root-screen-manager'),
        _i1.RouteConfig(Onboarding_screen.name, path: '/on-boarding-screen'),
        _i1.RouteConfig(Search_places_screen.name,
            path: '/search-places-screen'),
        _i1.RouteConfig(Place_item_details_screen.name,
            path: '/place-item-details'),
        _i1.RouteConfig(Interest_screen.name, path: '/interest-screen'),
        _i1.RouteConfig(Add_time_line_screen.name,
            path: '/add-time-line-screen'),
        _i1.RouteConfig(Gallery_photo_view_wrapper_screen.name,
            path: '/gallery-photo-view-wrapper'),
        _i1.RouteConfig(Notification_screen.name,
            path: '/notifications-screen'),
        _i1.RouteConfig(Favorite_interests_screen.name,
            path: '/favorite-interests-screen'),
        _i1.RouteConfig(Add_calendar_screen.name, path: '/add-calendar-screen'),
        _i1.RouteConfig(Add_activity_screen.name, path: '/add-activity-screen'),
        _i1.RouteConfig(Feedback_screen.name, path: '/feedback-screen'),
        _i1.RouteConfig(Albums_screen.name, path: '/albums-screen'),
        _i1.RouteConfig(Add_albums_screen.name, path: '/add-album-screen'),
        _i1.RouteConfig(Edit_albums_screen.name, path: '/edit-album-screen'),
        _i1.RouteConfig(Success_screen.name, path: '/custom-success-screen'),
        _i1.RouteConfig(Configuration_screen.name,
            path: '/configuration-screen'),
        _i1.RouteConfig(Home_partial.name, path: '/home-partial'),
        _i1.RouteConfig(Me_authenticated_partial.name,
            path: '/me-authenticated-partial'),
        _i1.RouteConfig(Invite_screen.name, path: '/invite-screen'),
        _i1.RouteConfig(Unsync_couple_screen.name,
            path: '/unsync-couple-screen'),
        _i1.RouteConfig(Add_suggestions_screen.name,
            path: '/add-suggestion-screen'),
        _i1.RouteConfig(Login_wrapper_screen.name,
            path: '/login-wrapper-screen')
      ];
}

class Authentication_wrapper_screen extends _i1.PageRouteInfo {
  const Authentication_wrapper_screen() : super(name, path: '/');

  static const String name = 'Authentication_wrapper_screen';
}

class Root_screen_manager_screen extends _i1.PageRouteInfo {
  const Root_screen_manager_screen()
      : super(name, path: '/root-screen-manager');

  static const String name = 'Root_screen_manager_screen';
}

class Onboarding_screen extends _i1.PageRouteInfo {
  const Onboarding_screen() : super(name, path: '/on-boarding-screen');

  static const String name = 'Onboarding_screen';
}

class Search_places_screen extends _i1.PageRouteInfo {
  const Search_places_screen() : super(name, path: '/search-places-screen');

  static const String name = 'Search_places_screen';
}

class Place_item_details_screen
    extends _i1.PageRouteInfo<Place_item_details_screenArgs> {
  Place_item_details_screen({_i2.Key? key, required _i26.PlaceModel? item})
      : super(name,
            path: '/place-item-details',
            args: Place_item_details_screenArgs(key: key, item: item));

  static const String name = 'Place_item_details_screen';
}

class Place_item_details_screenArgs {
  const Place_item_details_screenArgs({this.key, required this.item});

  final _i2.Key? key;

  final _i26.PlaceModel? item;
}

class Interest_screen extends _i1.PageRouteInfo<Interest_screenArgs> {
  Interest_screen({_i2.Key? key, required bool? isChangeFilter})
      : super(name,
            path: '/interest-screen',
            args:
                Interest_screenArgs(key: key, isChangeFilter: isChangeFilter));

  static const String name = 'Interest_screen';
}

class Interest_screenArgs {
  const Interest_screenArgs({this.key, required this.isChangeFilter});

  final _i2.Key? key;

  final bool? isChangeFilter;
}

class Add_time_line_screen extends _i1.PageRouteInfo {
  const Add_time_line_screen() : super(name, path: '/add-time-line-screen');

  static const String name = 'Add_time_line_screen';
}

class Gallery_photo_view_wrapper_screen
    extends _i1.PageRouteInfo<Gallery_photo_view_wrapper_screenArgs> {
  Gallery_photo_view_wrapper_screen(
      {_i2.Widget Function(_i2.BuildContext, _i2.ImageChunkEvent?)?
          loadingBuilder,
      _i2.Decoration? backgroundDecoration,
      dynamic minScale,
      dynamic maxScale,
      required int initialIndex,
      required List<_i27.GalleryImageModel>? galleryItems,
      required _i28.GalleryPhotoSourceTypeEnum? galleryPhotoSourceType,
      _i2.Axis? scrollDirection})
      : super(name,
            path: '/gallery-photo-view-wrapper',
            args: Gallery_photo_view_wrapper_screenArgs(
                loadingBuilder: loadingBuilder,
                backgroundDecoration: backgroundDecoration,
                minScale: minScale,
                maxScale: maxScale,
                initialIndex: initialIndex,
                galleryItems: galleryItems,
                galleryPhotoSourceType: galleryPhotoSourceType,
                scrollDirection: scrollDirection));

  static const String name = 'Gallery_photo_view_wrapper_screen';
}

class Gallery_photo_view_wrapper_screenArgs {
  const Gallery_photo_view_wrapper_screenArgs(
      {this.loadingBuilder,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      required this.initialIndex,
      required this.galleryItems,
      required this.galleryPhotoSourceType,
      this.scrollDirection});

  final _i2.Widget Function(_i2.BuildContext, _i2.ImageChunkEvent?)?
      loadingBuilder;

  final _i2.Decoration? backgroundDecoration;

  final dynamic minScale;

  final dynamic maxScale;

  final int initialIndex;

  final List<_i27.GalleryImageModel>? galleryItems;

  final _i28.GalleryPhotoSourceTypeEnum? galleryPhotoSourceType;

  final _i2.Axis? scrollDirection;
}

class Notification_screen extends _i1.PageRouteInfo {
  const Notification_screen() : super(name, path: '/notifications-screen');

  static const String name = 'Notification_screen';
}

class Favorite_interests_screen extends _i1.PageRouteInfo {
  const Favorite_interests_screen()
      : super(name, path: '/favorite-interests-screen');

  static const String name = 'Favorite_interests_screen';
}

class Add_calendar_screen extends _i1.PageRouteInfo<Add_calendar_screenArgs> {
  Add_calendar_screen({_i2.Key? key, _i29.TaskCalendarModel? taskModel})
      : super(name,
            path: '/add-calendar-screen',
            args: Add_calendar_screenArgs(key: key, taskModel: taskModel));

  static const String name = 'Add_calendar_screen';
}

class Add_calendar_screenArgs {
  const Add_calendar_screenArgs({this.key, this.taskModel});

  final _i2.Key? key;

  final _i29.TaskCalendarModel? taskModel;
}

class Add_activity_screen extends _i1.PageRouteInfo<Add_activity_screenArgs> {
  Add_activity_screen(
      {_i2.Key? key,
      required _i30.AddActivityCubit? activityCubit,
      required _i31.AddCalendarCubit? addCalendarCubit})
      : super(name,
            path: '/add-activity-screen',
            args: Add_activity_screenArgs(
                key: key,
                activityCubit: activityCubit,
                addCalendarCubit: addCalendarCubit));

  static const String name = 'Add_activity_screen';
}

class Add_activity_screenArgs {
  const Add_activity_screenArgs(
      {this.key, required this.activityCubit, required this.addCalendarCubit});

  final _i2.Key? key;

  final _i30.AddActivityCubit? activityCubit;

  final _i31.AddCalendarCubit? addCalendarCubit;
}

class Feedback_screen extends _i1.PageRouteInfo {
  const Feedback_screen() : super(name, path: '/feedback-screen');

  static const String name = 'Feedback_screen';
}

class Albums_screen extends _i1.PageRouteInfo {
  const Albums_screen() : super(name, path: '/albums-screen');

  static const String name = 'Albums_screen';
}

class Add_albums_screen extends _i1.PageRouteInfo {
  const Add_albums_screen() : super(name, path: '/add-album-screen');

  static const String name = 'Add_albums_screen';
}

class Edit_albums_screen extends _i1.PageRouteInfo<Edit_albums_screenArgs> {
  Edit_albums_screen({_i2.Key? key, required _i32.AlbumItemModel? album})
      : super(name,
            path: '/edit-album-screen',
            args: Edit_albums_screenArgs(key: key, album: album));

  static const String name = 'Edit_albums_screen';
}

class Edit_albums_screenArgs {
  const Edit_albums_screenArgs({this.key, required this.album});

  final _i2.Key? key;

  final _i32.AlbumItemModel? album;
}

class Success_screen extends _i1.PageRouteInfo<Success_screenArgs> {
  Success_screen({_i2.Key? key, required _i2.Widget child})
      : super(name,
            path: '/custom-success-screen',
            args: Success_screenArgs(key: key, child: child));

  static const String name = 'Success_screen';
}

class Success_screenArgs {
  const Success_screenArgs({this.key, required this.child});

  final _i2.Key? key;

  final _i2.Widget child;
}

class Configuration_screen extends _i1.PageRouteInfo {
  const Configuration_screen() : super(name, path: '/configuration-screen');

  static const String name = 'Configuration_screen';
}

class Home_partial extends _i1.PageRouteInfo {
  const Home_partial() : super(name, path: '/home-partial');

  static const String name = 'Home_partial';
}

class Me_authenticated_partial extends _i1.PageRouteInfo {
  const Me_authenticated_partial()
      : super(name, path: '/me-authenticated-partial');

  static const String name = 'Me_authenticated_partial';
}

class Invite_screen extends _i1.PageRouteInfo<Invite_screenArgs> {
  Invite_screen({_i2.Key? key, required _i33.InviteCubit? inviteCubit})
      : super(name,
            path: '/invite-screen',
            args: Invite_screenArgs(key: key, inviteCubit: inviteCubit));

  static const String name = 'Invite_screen';
}

class Invite_screenArgs {
  const Invite_screenArgs({this.key, required this.inviteCubit});

  final _i2.Key? key;

  final _i33.InviteCubit? inviteCubit;
}

class Unsync_couple_screen extends _i1.PageRouteInfo {
  const Unsync_couple_screen() : super(name, path: '/unsync-couple-screen');

  static const String name = 'Unsync_couple_screen';
}

class Add_suggestions_screen extends _i1.PageRouteInfo {
  const Add_suggestions_screen() : super(name, path: '/add-suggestion-screen');

  static const String name = 'Add_suggestions_screen';
}

class Login_wrapper_screen extends _i1.PageRouteInfo {
  const Login_wrapper_screen() : super(name, path: '/login-wrapper-screen');

  static const String name = 'Login_wrapper_screen';
}
