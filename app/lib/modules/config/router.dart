import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mozin/authentication_wrapper.dart';
import 'package:mozin/features/albums/presentation/pages/add_album_screen.dart';
import 'package:mozin/features/albums/presentation/pages/albums_screen.dart';
import 'package:mozin/features/albums/presentation/pages/edit_album_screen.dart';
import 'package:mozin/features/calendar/presentation/pages/add_activity_screen.dart';
import 'package:mozin/features/calendar/presentation/pages/add_calendar_screen.dart';
import 'package:mozin/features/configuration/presentation/pages/configuration_screen.dart';
import 'package:mozin/features/favoriteinterests/presentation/pages/favorite_interests_screen.dart';
import 'package:mozin/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:mozin/features/interest/presentation/pages/interest_screen.dart';
import 'package:mozin/features/invite/presentation/pages/invite_screen.dart';
import 'package:mozin/features/me/presentation/pages/widgets/login/login_wrapper_screen.dart';
import 'package:mozin/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:mozin/features/suggestions/presentation/pages/add_suggestion_screen.dart';
import 'package:mozin/features/unsync_couple/presentation/pages/unsync_couple_screen.dart';
import 'package:custom_view/custom_success_screen.dart';
import 'package:mozin/features/places/presentation/pages/place_item_details.dart';
import 'package:mozin/features/places/presentation/pages/search_places_screen.dart';
import 'package:mozin/features/screen_manager/presentation/root_screen_manager.dart';
import 'package:mozin/features/time_line/presentation/pages/add_time_line_screen.dart';
import 'package:mozin/modules/shared/custom_view_migrate/gallery_images/gallery_photo_view_wrapper.dart';
import 'package:mozin/modules/shared/custom_view_migrate/onboading_screen.dart'; 

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    
    AutoRoute(name: 'authentication_wrapper_screen', page: AuthenticationWrapper, initial: true),
    AutoRoute(name: 'root_screen_manager_screen', page: RootScreenManager,),
    AutoRoute(name: 'onboarding_screen', page: OnBoardingScreen,),
    AutoRoute(name: 'search_places_screen', page: SearchPlacesScreen,),
    AutoRoute(name: 'place_item_details_screen', page: PlaceItemDetails,),
    AutoRoute(name: 'interest_screen', page: InterestScreen,),
    AutoRoute(name: 'add_time_line_screen', page: AddTimeLineScreen,),
    AutoRoute(name: 'gallery_photo_view_wrapper_screen', page: GalleryPhotoViewWrapper,),
    AutoRoute(name: 'notification_screen', page: NotificationsScreen,),
    AutoRoute(name: 'favorite_interests_screen', page: FavoriteInterestsScreen,),
    AutoRoute(name: 'add_calendar_screen', page: AddCalendarScreen,),
    AutoRoute(name: 'add_activity_screen', page: AddActivityScreen,),
    AutoRoute(name: 'feedback_screen', page: FeedbackScreen,),
    AutoRoute(name: 'albums_screen', page: AlbumsScreen,),
    AutoRoute(name: 'add_albums_screen', page: AddAlbumScreen,),
    AutoRoute(name: 'edit_albums_screen', page: EditAlbumScreen,),
    AutoRoute(name: 'success_screen', page: CustomSuccessScreen,),
    AutoRoute(name: 'configuration_screen', page: ConfigurationScreen,),
    AutoRoute(name: 'home_partial', page: HomePartial,),
    AutoRoute(name: 'me_authenticated_partial', page: MeAuthenticatedPartial,),
    AutoRoute(name: 'invite_screen', page: InviteScreen,),
    AutoRoute(name: 'unsync_couple_screen', page: UnsyncCoupleScreen,),
    AutoRoute(name: 'add_suggestions_screen', page: AddSuggestionScreen,),
    AutoRoute(name: 'login_wrapper_screen', page: LoginWrapperScreen,),
  ],
)
class $AppRouter {}

class HomePartial extends Widget {
  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}

class MeAuthenticatedPartial extends Widget {
  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}