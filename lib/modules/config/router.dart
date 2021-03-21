import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/albums/presentation/pages/add_albums_screen.dart';
import 'package:mozin/features/albums/presentation/pages/albums_screen.dart';
import 'package:mozin/features/calendar/presentation/pages/add_activity_screen.dart';
import 'package:mozin/features/calendar/presentation/pages/add_calendar_screen.dart';
import 'package:mozin/features/calendar/presentation/pages/calendar_screen.dart';
import 'package:mozin/features/configuration/presentation/pages/configuration_screen.dart';
import 'package:mozin/features/favoriteinterests/presentation/pages/favorite_interests_screen.dart';
import 'package:mozin/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:mozin/features/interest/presentation/pages/interest_screen.dart';
import 'package:mozin/features/intro/presentation/pages/intro_screen.dart';
import 'package:mozin/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:mozin/package_view/custom_success_screen.dart';
import 'package:mozin/package_view/gallery_images/gallery_photo_view_wrapper.dart';
import 'package:mozin/package_view/onboading_screen.dart';
import 'package:mozin/features/places/presentation/pages/place_item_details.dart';
import 'package:mozin/features/places/presentation/pages/search_places_screen.dart';
import 'package:mozin/features/screen_manager/presentation/screen_manager.dart';
import 'package:mozin/features/time_line/presentation/pages/add_time_line_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(name: 'intro_screen', page: IntroScreen, initial: true),
    MaterialRoute(name: 'screen_manager', page: ScreenManager,),
    MaterialRoute(name: 'onboarding_screen', page: OnBoardingScreen,),
    MaterialRoute(name: 'search_places_screen', page: SearchPlacesScreen,),
    MaterialRoute(name: 'place_item_details', page: PlaceItemDetails,),
    MaterialRoute(name: 'interest_screen', page: InterestScreen,),
    MaterialRoute(name: 'add_time_line_screen', page: AddTimeLineScreen,),
    MaterialRoute(name: 'gallery_photo_view_wrapper', page: GalleryPhotoViewWrapper,),
    MaterialRoute(name: 'notification', page: NotificationsScreen,),
    MaterialRoute(name: 'favorite_interests', page: FavoriteInterestsScreen,),
    MaterialRoute(name: 'calendar', page: CalendarScreen,),
    MaterialRoute(name: 'add_calendar', page: AddCalendarScreen,),
    MaterialRoute(name: 'add_activity', page: AddActivityScreen,),
    MaterialRoute(name: 'feedback', page: FeedbackScreen,),
    MaterialRoute(name: 'albums_screen', page: AlbumsScreen,),
    MaterialRoute(name: 'add_albums_screen', page: AddAlbumsScreen,),
    MaterialRoute(name: 'success_screen', page: CustomSuccessScreen,),
    MaterialRoute(name: 'configuration_screen', page: ConfigurationScreen,),
    MaterialRoute(name: 'home_partial', page: HomePartial,),
  ],
)
class $Router {}

class HomePartial extends Widget {
  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}