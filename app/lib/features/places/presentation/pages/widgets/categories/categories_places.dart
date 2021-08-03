import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/ads/presentation/pages/banners/publisher_banner_ad_widget.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/cubit/categories_places_cubit.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/sub_categories_places.dart';
import 'package:mozin/features/places/presentation/pages/widgets/place_card_item.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/custom_quadrant.dart';
import 'package:custom_view/spacer_box.dart';

class CategoriesPlaces extends StatefulWidget {
  const CategoriesPlaces({Key key, @required this.places}) : super(key: key);

  final List<PlacesCategory> places;

  @override
  _CategoriesPlacesState createState() => _CategoriesPlacesState();
}

class _CategoriesPlacesState extends State<CategoriesPlaces> {
  CategoriesPlacesCubit _categoriesPlacesCubit;
  CategoriesPlacesAds _categoriesPlacesAds;

  @override
  void initState() {
    _categoriesPlacesAds = CategoriesPlacesAds();
    _categoriesPlacesCubit = getItInstance<CategoriesPlacesCubit>()
      ..loadPrimary(widget.places);

    super.initState();
  }

  @override
  void dispose() {
    _categoriesPlacesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategories(),
        SpacerBox.v8,
        _buildTabs(),
        SpacerBox.v16,
        _buildContentTabs(),
      ],
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<CategoriesPlacesCubit, CategoriesPlacesState>(
      cubit: _categoriesPlacesCubit,
      buildWhen: (previous, current) {
        return previous.places != current.places ||
            previous.categorySelected != current.categorySelected;
      },
      builder: (context, state) {
        if (state.places.length > 0) {
          return Container(
            height: SizeConfig.sizeByPixel(35),
            child: ListView.separated(
              separatorBuilder: (context, index) => SpacerBox.h8,
              scrollDirection: Axis.horizontal,
              itemCount: state.places.length,
              itemBuilder: (context, index) => CustomQuadrant(
                isSelected: state.categorySelected == state.places[index],
                text: state.places[index].categoryName,
                callbackSelected: (isSelected) {
                  _categoriesPlacesCubit.categorySelected(state.places[index]);
                },
              ),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildTabs() {
    return BlocBuilder<CategoriesPlacesCubit, CategoriesPlacesState>(
      cubit: _categoriesPlacesCubit,
      buildWhen: (previous, current) {
        return previous.categorySelected != current.categorySelected;
      },
      builder: (context, state) {
        if (state.categorySelected != null) {
          return SubCategoriesPlaces(
            subCategories: state.categorySelected.subCategories,
            tabstitle: state.tabsTitle,
            categoriesPlacesCubit: _categoriesPlacesCubit,
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildContentTabs() {
    return BlocBuilder<CategoriesPlacesCubit, CategoriesPlacesState>(
      cubit: _categoriesPlacesCubit,
      buildWhen: (previous, current) {
        return previous.content != current.content;
      },
      builder: (context, state) {
        if (state.content.length > 0) {
          return Expanded(
            child: ListView.separated(
              itemCount: state.content.length,
              itemBuilder: (context, index) {
                var item = state.content[index];
                return PlaceCardItem(
                  item: item,
                );
              },
              separatorBuilder: (context, index) => Column(
                children: [
                  ..._categoriesPlacesAds.showAd(AdsBannerType.banner, index),
                  ..._categoriesPlacesAds.showAd(
                      AdsBannerType.publisherBanner, index),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

enum AdsBannerType { banner, publisherBanner }

class AdsBannerConfig {
  AdsBannerConfig({
    @required this.skipAt,
    @required this.initialIndex,
    @required this.type,
    this.lastIndex,
  });

  final AdsBannerType type;
  final int skipAt;
  final int initialIndex;
  int lastIndex;
}

abstract class AdsBase {
  Map<AdsBannerType, AdsBannerConfig> ads = {};

  void init();
  List<Widget> buildBanner();
  List<Widget> buildPublisherBanner();

  List<Widget> showAd(AdsBannerType type, int currentIndex) {
    switch (type) {
      case AdsBannerType.banner:
        AdsBannerConfig _config = ads[AdsBannerType.banner];
        if (_config.initialIndex == currentIndex ||
            _config.lastIndex != null &&
                ((_config.lastIndex == currentIndex) ||
                    ((_config.lastIndex + _config.skipAt) == currentIndex))) {
                      
          _config.lastIndex = currentIndex;
          return buildBanner();
        }
        break;
      case AdsBannerType.publisherBanner:
        AdsBannerConfig _config = ads[AdsBannerType.publisherBanner];

        if (_config.initialIndex == currentIndex ||
            _config.lastIndex != null &&
                ((_config.lastIndex == currentIndex) ||
                    ((_config.lastIndex + _config.skipAt) == currentIndex))) {

          _config.lastIndex = currentIndex;
          return buildPublisherBanner();
        }
        break;
      default:
        return [SpacerBox.v16];
    }

    return [SpacerBox.v16];
  }
}

class CategoriesPlacesAds extends AdsBase {
  CategoriesPlacesAds() {
    init();
  }

  @override
  void init() {
    ads = {
      AdsBannerType.banner: AdsBannerConfig(
        type: AdsBannerType.banner,
        initialIndex: 2,
        skipAt: 9,
      ),
      AdsBannerType.publisherBanner: AdsBannerConfig(
        type: AdsBannerType.publisherBanner,
        initialIndex: 6,
        skipAt: 9,
      ),
    };
  }

  @override
  List<Widget> buildBanner() {
    return [
      SpacerBox.v16,
      BannerAdWidget(
        screenName: Routes.search_places_screen,
        itemCount: 1,
        indexRender: 0,
      ),
      SpacerBox.v16,
    ];
  }

  @override
  List<Widget> buildPublisherBanner() {
    return [
      SpacerBox.v16,
      PublisherBannerAdWidget(
        screenName: Routes.search_places_screen,
        itemCount: 1,
        indexRender: 0,
      ),
      SpacerBox.v16,
    ];
  }
}
