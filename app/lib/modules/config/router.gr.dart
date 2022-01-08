// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i24;
import 'package:custom_view/custom_success_screen.dart' as _i17;
import 'package:flutter/material.dart' as _i25;

import '../../authentication_wrapper.dart' as _i1;
import '../../features/albums/data/models/album_item_model.dart' as _i32;
import '../../features/albums/presentation/pages/add_album_screen.dart' as _i15;
import '../../features/albums/presentation/pages/albums_screen.dart' as _i14;
import '../../features/albums/presentation/pages/edit_album_screen.dart'
    as _i16;
import '../../features/calendar/data/models/task_calendar_model.dart' as _i29;
import '../../features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart'
    as _i30;
import '../../features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart'
    as _i31;
import '../../features/calendar/presentation/pages/add_activity_screen.dart'
    as _i12;
import '../../features/calendar/presentation/pages/add_calendar_screen.dart'
    as _i11;
import '../../features/configuration/presentation/pages/configuration_screen.dart'
    as _i18;
import '../../features/favoriteinterests/presentation/pages/favorite_interests_screen.dart'
    as _i10;
import '../../features/feedback/presentation/pages/feedback_screen.dart'
    as _i13;
import '../../features/interest/presentation/pages/interest_screen.dart' as _i6;
import '../../features/invite/presentation/bloc/invite_cubit.dart' as _i33;
import '../../features/invite/presentation/pages/invite_screen.dart' as _i20;
import '../../features/me/presentation/pages/widgets/login/login_wrapper_screen.dart'
    as _i23;
import '../../features/notifications/presentation/pages/notifications_screen.dart'
    as _i9;
import '../../features/places/data/models/place_model.dart' as _i26;
import '../../features/places/presentation/pages/place_item_details.dart'
    as _i5;
import '../../features/places/presentation/pages/search_places_screen.dart'
    as _i4;
import '../../features/screen_manager/presentation/root_screen_manager.dart'
    as _i2;
import '../../features/suggestions/presentation/pages/add_suggestion_screen.dart'
    as _i22;
import '../../features/time_line/presentation/pages/add_time_line_screen.dart'
    as _i7;
import '../../features/unsync_couple/presentation/pages/unsync_couple_screen.dart'
    as _i21;
import '../shared/custom_view_migrate/gallery_images/gallery_photo_source_type_enum.dart'
    as _i28;
import '../shared/custom_view_migrate/gallery_images/gallery_photo_view_wrapper.dart'
    as _i8;
import '../shared/custom_view_migrate/onboading_screen.dart' as _i3;
import '../shared/general/models/gallery_image_model.dart' as _i27;
import 'router.dart' as _i19;

class AppRouter extends _i24.RootStackRouter {
  AppRouter([_i25.GlobalKey<_i25.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i24.PageFactory> pagesMap = {
    Authentication_wrapper_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AuthenticationWrapper());
    },
    Root_screen_manager_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.RootScreenManager());
    },
    Onboarding_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.OnBoardingScreen());
    },
    Search_places_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SearchPlacesScreen());
    },
    Place_item_details_screen.name: (routeData) {
      final args = routeData.argsAs<Place_item_details_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.PlaceItemDetails(key: args.key, item: args.item));
    },
    Interest_screen.name: (routeData) {
      final args = routeData.argsAs<Interest_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.InterestScreen(
              key: args.key, isChangeFilter: args.isChangeFilter));
    },
    Add_time_line_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.AddTimeLineScreen());
    },
    Gallery_photo_view_wrapper_screen.name: (routeData) {
      final args = routeData.argsAs<Gallery_photo_view_wrapper_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.GalleryPhotoViewWrapper(
              loadingBuilder: args.loadingBuilder,
              backgroundDecoration: args.backgroundDecoration,
              minScale: args.minScale,
              maxScale: args.maxScale,
              initialIndex: args.initialIndex,
              galleryItems: args.galleryItems,
              galleryPhotoSourceType: args.galleryPhotoSourceType,
              scrollDirection: args.scrollDirection));
    },
    Notification_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.NotificationsScreen());
    },
    Favorite_interests_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.FavoriteInterestsScreen());
    },
    Add_calendar_screen.name: (routeData) {
      final args = routeData.argsAs<Add_calendar_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.AddCalendarScreen(
              key: args.key,
              taskModel: args.taskModel,
              selectedDate: args.selectedDate));
    },
    Add_activity_screen.name: (routeData) {
      final args = routeData.argsAs<Add_activity_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.AddActivityScreen(
              key: args.key,
              activityCubit: args.activityCubit,
              addCalendarCubit: args.addCalendarCubit));
    },
    Feedback_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.FeedbackScreen());
    },
    Albums_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.AlbumsScreen());
    },
    Add_albums_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.AddAlbumScreen());
    },
    Edit_albums_screen.name: (routeData) {
      final args = routeData.argsAs<Edit_albums_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i16.EditAlbumScreen(key: args.key, album: args.album));
    },
    Success_screen.name: (routeData) {
      final args = routeData.argsAs<Success_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.CustomSuccessScreen(key: args.key, child: args.child));
    },
    Configuration_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i18.ConfigurationScreen());
    },
    Home_partial.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i19.HomePartial());
    },
    Me_authenticated_partial.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: _i19.MeAuthenticatedPartial());
    },
    Invite_screen.name: (routeData) {
      final args = routeData.argsAs<Invite_screenArgs>();
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i20.InviteScreen(key: args.key, inviteCubit: args.inviteCubit));
    },
    Unsync_couple_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.UnsyncCoupleScreen());
    },
    Add_suggestions_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.AddSuggestionScreen());
    },
    Login_wrapper_screen.name: (routeData) {
      return _i24.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.LoginWrapperScreen());
    }
  };

  @override
  List<_i24.RouteConfig> get routes => [
        _i24.RouteConfig(Authentication_wrapper_screen.name, path: '/'),
        _i24.RouteConfig(Root_screen_manager_screen.name,
            path: '/root-screen-manager'),
        _i24.RouteConfig(Onboarding_screen.name, path: '/on-boarding-screen'),
        _i24.RouteConfig(Search_places_screen.name,
            path: '/search-places-screen'),
        _i24.RouteConfig(Place_item_details_screen.name,
            path: '/place-item-details'),
        _i24.RouteConfig(Interest_screen.name, path: '/interest-screen'),
        _i24.RouteConfig(Add_time_line_screen.name,
            path: '/add-time-line-screen'),
        _i24.RouteConfig(Gallery_photo_view_wrapper_screen.name,
            path: '/gallery-photo-view-wrapper'),
        _i24.RouteConfig(Notification_screen.name,
            path: '/notifications-screen'),
        _i24.RouteConfig(Favorite_interests_screen.name,
            path: '/favorite-interests-screen'),
        _i24.RouteConfig(Add_calendar_screen.name,
            path: '/add-calendar-screen'),
        _i24.RouteConfig(Add_activity_screen.name,
            path: '/add-activity-screen'),
        _i24.RouteConfig(Feedback_screen.name, path: '/feedback-screen'),
        _i24.RouteConfig(Albums_screen.name, path: '/albums-screen'),
        _i24.RouteConfig(Add_albums_screen.name, path: '/add-album-screen'),
        _i24.RouteConfig(Edit_albums_screen.name, path: '/edit-album-screen'),
        _i24.RouteConfig(Success_screen.name, path: '/custom-success-screen'),
        _i24.RouteConfig(Configuration_screen.name,
            path: '/configuration-screen'),
        _i24.RouteConfig(Home_partial.name, path: '/home-partial'),
        _i24.RouteConfig(Me_authenticated_partial.name,
            path: '/me-authenticated-partial'),
        _i24.RouteConfig(Invite_screen.name, path: '/invite-screen'),
        _i24.RouteConfig(Unsync_couple_screen.name,
            path: '/unsync-couple-screen'),
        _i24.RouteConfig(Add_suggestions_screen.name,
            path: '/add-suggestion-screen'),
        _i24.RouteConfig(Login_wrapper_screen.name,
            path: '/login-wrapper-screen')
      ];
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class Authentication_wrapper_screen extends _i24.PageRouteInfo<void> {
  const Authentication_wrapper_screen()
      : super(Authentication_wrapper_screen.name, path: '/');

  static const String name = 'Authentication_wrapper_screen';
}

/// generated route for
/// [_i2.RootScreenManager]
class Root_screen_manager_screen extends _i24.PageRouteInfo<void> {
  const Root_screen_manager_screen()
      : super(Root_screen_manager_screen.name, path: '/root-screen-manager');

  static const String name = 'Root_screen_manager_screen';
}

/// generated route for
/// [_i3.OnBoardingScreen]
class Onboarding_screen extends _i24.PageRouteInfo<void> {
  const Onboarding_screen()
      : super(Onboarding_screen.name, path: '/on-boarding-screen');

  static const String name = 'Onboarding_screen';
}

/// generated route for
/// [_i4.SearchPlacesScreen]
class Search_places_screen extends _i24.PageRouteInfo<void> {
  const Search_places_screen()
      : super(Search_places_screen.name, path: '/search-places-screen');

  static const String name = 'Search_places_screen';
}

/// generated route for
/// [_i5.PlaceItemDetails]
class Place_item_details_screen
    extends _i24.PageRouteInfo<Place_item_details_screenArgs> {
  Place_item_details_screen({_i25.Key? key, required _i26.PlaceModel? item})
      : super(Place_item_details_screen.name,
            path: '/place-item-details',
            args: Place_item_details_screenArgs(key: key, item: item));

  static const String name = 'Place_item_details_screen';
}

class Place_item_details_screenArgs {
  const Place_item_details_screenArgs({this.key, required this.item});

  final _i25.Key? key;

  final _i26.PlaceModel? item;

  @override
  String toString() {
    return 'Place_item_details_screenArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i6.InterestScreen]
class Interest_screen extends _i24.PageRouteInfo<Interest_screenArgs> {
  Interest_screen({_i25.Key? key, required bool? isChangeFilter})
      : super(Interest_screen.name,
            path: '/interest-screen',
            args:
                Interest_screenArgs(key: key, isChangeFilter: isChangeFilter));

  static const String name = 'Interest_screen';
}

class Interest_screenArgs {
  const Interest_screenArgs({this.key, required this.isChangeFilter});

  final _i25.Key? key;

  final bool? isChangeFilter;

  @override
  String toString() {
    return 'Interest_screenArgs{key: $key, isChangeFilter: $isChangeFilter}';
  }
}

/// generated route for
/// [_i7.AddTimeLineScreen]
class Add_time_line_screen extends _i24.PageRouteInfo<void> {
  const Add_time_line_screen()
      : super(Add_time_line_screen.name, path: '/add-time-line-screen');

  static const String name = 'Add_time_line_screen';
}

/// generated route for
/// [_i8.GalleryPhotoViewWrapper]
class Gallery_photo_view_wrapper_screen
    extends _i24.PageRouteInfo<Gallery_photo_view_wrapper_screenArgs> {
  Gallery_photo_view_wrapper_screen(
      {_i25.Widget Function(_i25.BuildContext, _i25.ImageChunkEvent?)?
          loadingBuilder,
      _i25.Decoration? backgroundDecoration,
      dynamic minScale,
      dynamic maxScale,
      required int initialIndex,
      required List<_i27.GalleryImageModel>? galleryItems,
      required _i28.GalleryPhotoSourceTypeEnum? galleryPhotoSourceType,
      _i25.Axis? scrollDirection = _i25.Axis.horizontal})
      : super(Gallery_photo_view_wrapper_screen.name,
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
      this.scrollDirection = _i25.Axis.horizontal});

  final _i25.Widget Function(_i25.BuildContext, _i25.ImageChunkEvent?)?
      loadingBuilder;

  final _i25.Decoration? backgroundDecoration;

  final dynamic minScale;

  final dynamic maxScale;

  final int initialIndex;

  final List<_i27.GalleryImageModel>? galleryItems;

  final _i28.GalleryPhotoSourceTypeEnum? galleryPhotoSourceType;

  final _i25.Axis? scrollDirection;

  @override
  String toString() {
    return 'Gallery_photo_view_wrapper_screenArgs{loadingBuilder: $loadingBuilder, backgroundDecoration: $backgroundDecoration, minScale: $minScale, maxScale: $maxScale, initialIndex: $initialIndex, galleryItems: $galleryItems, galleryPhotoSourceType: $galleryPhotoSourceType, scrollDirection: $scrollDirection}';
  }
}

/// generated route for
/// [_i9.NotificationsScreen]
class Notification_screen extends _i24.PageRouteInfo<void> {
  const Notification_screen()
      : super(Notification_screen.name, path: '/notifications-screen');

  static const String name = 'Notification_screen';
}

/// generated route for
/// [_i10.FavoriteInterestsScreen]
class Favorite_interests_screen extends _i24.PageRouteInfo<void> {
  const Favorite_interests_screen()
      : super(Favorite_interests_screen.name,
            path: '/favorite-interests-screen');

  static const String name = 'Favorite_interests_screen';
}

/// generated route for
/// [_i11.AddCalendarScreen]
class Add_calendar_screen extends _i24.PageRouteInfo<Add_calendar_screenArgs> {
  Add_calendar_screen(
      {_i25.Key? key,
      _i29.TaskCalendarModel? taskModel,
      required DateTime selectedDate})
      : super(Add_calendar_screen.name,
            path: '/add-calendar-screen',
            args: Add_calendar_screenArgs(
                key: key, taskModel: taskModel, selectedDate: selectedDate));

  static const String name = 'Add_calendar_screen';
}

class Add_calendar_screenArgs {
  const Add_calendar_screenArgs(
      {this.key, this.taskModel, required this.selectedDate});

  final _i25.Key? key;

  final _i29.TaskCalendarModel? taskModel;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'Add_calendar_screenArgs{key: $key, taskModel: $taskModel, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [_i12.AddActivityScreen]
class Add_activity_screen extends _i24.PageRouteInfo<Add_activity_screenArgs> {
  Add_activity_screen(
      {_i25.Key? key,
      required _i30.AddActivityCubit? activityCubit,
      required _i31.AddCalendarCubit? addCalendarCubit})
      : super(Add_activity_screen.name,
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

  final _i25.Key? key;

  final _i30.AddActivityCubit? activityCubit;

  final _i31.AddCalendarCubit? addCalendarCubit;

  @override
  String toString() {
    return 'Add_activity_screenArgs{key: $key, activityCubit: $activityCubit, addCalendarCubit: $addCalendarCubit}';
  }
}

/// generated route for
/// [_i13.FeedbackScreen]
class Feedback_screen extends _i24.PageRouteInfo<void> {
  const Feedback_screen()
      : super(Feedback_screen.name, path: '/feedback-screen');

  static const String name = 'Feedback_screen';
}

/// generated route for
/// [_i14.AlbumsScreen]
class Albums_screen extends _i24.PageRouteInfo<void> {
  const Albums_screen() : super(Albums_screen.name, path: '/albums-screen');

  static const String name = 'Albums_screen';
}

/// generated route for
/// [_i15.AddAlbumScreen]
class Add_albums_screen extends _i24.PageRouteInfo<void> {
  const Add_albums_screen()
      : super(Add_albums_screen.name, path: '/add-album-screen');

  static const String name = 'Add_albums_screen';
}

/// generated route for
/// [_i16.EditAlbumScreen]
class Edit_albums_screen extends _i24.PageRouteInfo<Edit_albums_screenArgs> {
  Edit_albums_screen({_i25.Key? key, required _i32.AlbumItemModel? album})
      : super(Edit_albums_screen.name,
            path: '/edit-album-screen',
            args: Edit_albums_screenArgs(key: key, album: album));

  static const String name = 'Edit_albums_screen';
}

class Edit_albums_screenArgs {
  const Edit_albums_screenArgs({this.key, required this.album});

  final _i25.Key? key;

  final _i32.AlbumItemModel? album;

  @override
  String toString() {
    return 'Edit_albums_screenArgs{key: $key, album: $album}';
  }
}

/// generated route for
/// [_i17.CustomSuccessScreen]
class Success_screen extends _i24.PageRouteInfo<Success_screenArgs> {
  Success_screen({_i25.Key? key, required _i25.Widget child})
      : super(Success_screen.name,
            path: '/custom-success-screen',
            args: Success_screenArgs(key: key, child: child));

  static const String name = 'Success_screen';
}

class Success_screenArgs {
  const Success_screenArgs({this.key, required this.child});

  final _i25.Key? key;

  final _i25.Widget child;

  @override
  String toString() {
    return 'Success_screenArgs{key: $key, child: $child}';
  }
}

/// generated route for
/// [_i18.ConfigurationScreen]
class Configuration_screen extends _i24.PageRouteInfo<void> {
  const Configuration_screen()
      : super(Configuration_screen.name, path: '/configuration-screen');

  static const String name = 'Configuration_screen';
}

/// generated route for
/// [_i19.HomePartial]
class Home_partial extends _i24.PageRouteInfo<void> {
  const Home_partial() : super(Home_partial.name, path: '/home-partial');

  static const String name = 'Home_partial';
}

/// generated route for
/// [_i19.MeAuthenticatedPartial]
class Me_authenticated_partial extends _i24.PageRouteInfo<void> {
  const Me_authenticated_partial()
      : super(Me_authenticated_partial.name, path: '/me-authenticated-partial');

  static const String name = 'Me_authenticated_partial';
}

/// generated route for
/// [_i20.InviteScreen]
class Invite_screen extends _i24.PageRouteInfo<Invite_screenArgs> {
  Invite_screen({_i25.Key? key, required _i33.InviteCubit? inviteCubit})
      : super(Invite_screen.name,
            path: '/invite-screen',
            args: Invite_screenArgs(key: key, inviteCubit: inviteCubit));

  static const String name = 'Invite_screen';
}

class Invite_screenArgs {
  const Invite_screenArgs({this.key, required this.inviteCubit});

  final _i25.Key? key;

  final _i33.InviteCubit? inviteCubit;

  @override
  String toString() {
    return 'Invite_screenArgs{key: $key, inviteCubit: $inviteCubit}';
  }
}

/// generated route for
/// [_i21.UnsyncCoupleScreen]
class Unsync_couple_screen extends _i24.PageRouteInfo<void> {
  const Unsync_couple_screen()
      : super(Unsync_couple_screen.name, path: '/unsync-couple-screen');

  static const String name = 'Unsync_couple_screen';
}

/// generated route for
/// [_i22.AddSuggestionScreen]
class Add_suggestions_screen extends _i24.PageRouteInfo<void> {
  const Add_suggestions_screen()
      : super(Add_suggestions_screen.name, path: '/add-suggestion-screen');

  static const String name = 'Add_suggestions_screen';
}

/// generated route for
/// [_i23.LoginWrapperScreen]
class Login_wrapper_screen extends _i24.PageRouteInfo<void> {
  const Login_wrapper_screen()
      : super(Login_wrapper_screen.name, path: '/login-wrapper-screen');

  static const String name = 'Login_wrapper_screen';
}
