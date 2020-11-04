// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/interest/presentation/pages/interest_screen.dart';
import '../../features/intro/presentation/pages/intro_screen.dart';
import '../../features/places/presentation/pages/place_item_details.dart';
import '../../features/places/presentation/pages/search_places_screen.dart';
import '../../features/screen_manager/presentation/screen_manager.dart';
import '../../features/time_line/presentation/pages/add_time_line_screen.dart';
import '../../package_view/gallery_images/gallery_photo_source_type_enum.dart';
import '../../package_view/gallery_images/gallery_photo_view_wrapper.dart';
import '../../package_view/onboading_screen.dart';
import '../shared/general/models/gallery_image_model.dart';

class Routes {
  static const String intro_screen = '/';
  static const String screen_manager = '/screen-manager';
  static const String onboarding_screen = '/on-boarding-screen';
  static const String search_places_screen = '/search-places-screen';
  static const String place_item_details = '/place-item-details';
  static const String interest_screen = '/interest-screen';
  static const String add_time_line_screen = '/add-time-line-screen';
  static const String gallery_photo_view_wrapper =
      '/gallery-photo-view-wrapper';
  static const all = <String>{
    intro_screen,
    screen_manager,
    onboarding_screen,
    search_places_screen,
    place_item_details,
    interest_screen,
    add_time_line_screen,
    gallery_photo_view_wrapper,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.intro_screen, page: IntroScreen),
    RouteDef(Routes.screen_manager, page: ScreenManager),
    RouteDef(Routes.onboarding_screen, page: OnBoardingScreen),
    RouteDef(Routes.search_places_screen, page: SearchPlacesScreen),
    RouteDef(Routes.place_item_details, page: PlaceItemDetails),
    RouteDef(Routes.interest_screen, page: InterestScreen),
    RouteDef(Routes.add_time_line_screen, page: AddTimeLineScreen),
    RouteDef(Routes.gallery_photo_view_wrapper, page: GalleryPhotoViewWrapper),
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => PlaceItemDetails(),
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
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

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
