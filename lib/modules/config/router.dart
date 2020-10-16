import 'package:auto_route/auto_route_annotations.dart';
import 'package:mozin/features/interest/presentation/pages/interest_screen.dart';
import 'package:mozin/views/day_one/day_one_screen.dart';
import 'package:mozin/views/gallery_images/gallery_photo_view_wrapper.dart';
import 'package:mozin/views/intro/intro_screen.dart';
import 'package:mozin/views/onboading_screen.dart';
import 'package:mozin/views/places/place_item_details.dart';
import 'package:mozin/views/places/search_places_screen.dart';
import 'package:mozin/views/screen_manager.dart';
import 'package:mozin/views/time_line/add_time_line_screen.dart';

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
    MaterialRoute(name: 'day_one_screen', page: DayOneScreen,),
    MaterialRoute(name: 'gallery_photo_view_wrapper', page: GalleryPhotoViewWrapper,),
  ],
)
class $Router {}