import 'package:custom_view/custom_item_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/ads/presentation/pages/banners/publisher_banner_ad_widget.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_item/favorite_interests_item_event.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/features/places/presentation/blocs/categories_places/categories_places_cubit.dart';
import 'package:mozin/features/places/presentation/blocs/categories_places/categories_places_state.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/sub_categories_places.dart';
import 'package:mozin/features/places/presentation/pages/widgets/place_card_item.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/features/suggestions/presentation/pages/widgets/suggestion_item.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/custom_quadrant.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin_core/ads/ads_config.dart';

class CategoriesPlaces extends StatefulWidget {
  const CategoriesPlaces({Key key, @required this.places}) : super(key: key);

  final List<PlacesCategory> places;

  @override
  _CategoriesPlacesState createState() => _CategoriesPlacesState();
}

class _CategoriesPlacesState extends State<CategoriesPlaces> {
  SuggestionsCubit _suggestionsCubit;
  CategoriesPlacesCubit _categoriesPlacesCubit;
  _CategoriesPlacesAds _categoriesPlacesAds;

  List<FavoriteInterestsItemBloc> _listFavoriteItemBlocs;

  @override
  void initState() {
    _listFavoriteItemBlocs = [];
    _suggestionsCubit = getItInstance<SuggestionsCubit>();
    _categoriesPlacesAds = _CategoriesPlacesAds();
    _categoriesPlacesCubit = getItInstance<CategoriesPlacesCubit>()
      ..loadPrimary(widget.places);

    super.initState();
  }

  @override
  void dispose() {
    _listFavoriteItemBlocs.forEach((element) { 
      element.close();
    });

    _categoriesPlacesCubit.close();
    _suggestionsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO:in development
        // _buildCategories(),
        // SpacerBox.v8,
        _buildTabs(),
        SpacerBox.v16,
        //TODO:in development
        //_buildSections(),
        _buildContentTabs(),
      ],
    );
  }

  Widget _buildSections() {
    return BlocBuilder<CategoriesPlacesCubit, CategoriesPlacesState>(
      cubit: _categoriesPlacesCubit,
      buildWhen: (previous, current) {
        return previous.interestSelected != current.interestSelected;
      },
      builder: (context, state) {
        if (state.sessions.length > 0) {
          return Container(
            height: SizeConfig.sizeByPixel(35),
            child: ListView.separated(
              separatorBuilder: (context, index) => SpacerBox.h8,
              scrollDirection: Axis.horizontal,
              itemCount: state.sessions.length,
              itemBuilder: (context, index) => CustomItemBadge(
                item: state.sessions[index],
                text: state.sessions[index].text,
                callbackSelected: (selected, item) {},
              ),
            ),
          );
        }

        return SizedBox.shrink();
      },
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
        return (previous.contentPlaces != current.contentPlaces) ||
            (previous.contentSuggestedByUsers !=
                current.contentSuggestedByUsers);
      },
      builder: (context, state) {
        if (state.interestSelected == InterestEnum.Place &&
            state.contentPlaces.length > 0) {
          return _buildContentPlace(state);
        } else if (state.interestSelected == InterestEnum.SuggestedByUsers &&
            state.contentSuggestedByUsers.length > 0) {
          return _buildContentSuggestedByUsers(state);
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildContentSuggestedByUsers(CategoriesPlacesState state) {
    return Expanded(
      child: ListView.separated(
        itemCount: state.contentSuggestedByUsers.length,
        itemBuilder: (context, index) {
          var item = state.contentSuggestedByUsers[index];
          
          final FavoriteInterestsItemBloc _favoriteItem = getItInstance<FavoriteInterestsItemBloc>()..add(SetFavoriteItem(item.favoriteAdded));
          _listFavoriteItemBlocs.add(_favoriteItem);

          return SuggestionItem(
            item: item,
            suggestionsCubit: _suggestionsCubit,
            favoriteInterestsItemBloc: _favoriteItem,
          );
        },
        separatorBuilder: (context, index) => Column(
          children: [
            ..._categoriesPlacesAds.showAd(
                AdsBannerType.banner, index, SpacerBox.v16),
            ..._categoriesPlacesAds.showAd(
                AdsBannerType.publisherBanner, index, SpacerBox.v16),
          ],
        ),
      ),
    );
  }

  Widget _buildContentPlace(CategoriesPlacesState state) {
    return Expanded(
      child: ListView.separated(
        itemCount: state.contentPlaces.length,
        itemBuilder: (context, index) {
          var item = state.contentPlaces[index];
          return PlaceCardItem(
            item: item,
          );
        },
        separatorBuilder: (context, index) => Column(
          children: [
            ..._categoriesPlacesAds.showAd(
                AdsBannerType.banner, index, SpacerBox.v16),
            ..._categoriesPlacesAds.showAd(
                AdsBannerType.publisherBanner, index, SpacerBox.v16),
          ],
        ),
      ),
    );
  }
}

class _CategoriesPlacesAds extends AdsBase {
  _CategoriesPlacesAds() {
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
