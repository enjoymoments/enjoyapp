import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/cubit/categories_places_cubit.dart';
import 'package:mozin/features/places/presentation/pages/widgets/categories/sub_categories_places.dart';
import 'package:mozin/features/places/presentation/pages/widgets/place_card_item.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/custom_quadrant.dart';
import 'package:mozin/package_view/spacer_box.dart';

class CategoriesPlaces extends StatefulWidget {
  const CategoriesPlaces({Key key, @required this.places}) : super(key: key);

  final List<PlacesCategory> places;

  @override
  _CategoriesPlacesState createState() => _CategoriesPlacesState();
}

class _CategoriesPlacesState extends State<CategoriesPlaces> {
  CategoriesPlacesCubit _categoriesPlacesCubit;

  @override
  void initState() {
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
        return previous.places != current.places || previous.categorySelected != current.categorySelected;
      },
      builder: (context, state) {
        if (state.places.length > 0) {
          return Container(
            height: SizeConfig.sizeByPixel(30),
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
              separatorBuilder: (context, index) => SpacerBox.v16,
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
