import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'categories_places_state.dart';

class CategoriesPlacesCubit extends Cubit<CategoriesPlacesState> {
  CategoriesPlacesCubit() : super(CategoriesPlacesState.initial());

  void loadPrimary(List<PlacesCategory> places) {
    var _categoryInitial = places[0];

    emit(
      state.copyWith(
        places: places,
        categorySelected: _categoryInitial,
        tabsTitle: _buildTabsTitle(_categoryInitial),
        content: _categoryInitial.subCategories[0].data,
      ),
    );
  }

  void categorySelected(PlacesCategory category) {
    emit(
      state.copyWith(
        categorySelected: category,
        tabsTitle: _buildTabsTitle(category),
        content: category.subCategories[0].data,
      ),
    );
  }

  void subCategorySelected(List<PlaceModel> data) {
    emit(state.copyWith(content: data));
  }

  List<Widget> _buildTabsTitle(PlacesCategory category) {
    return category.subCategories
        .map(
          (e) => Tab(
            text: e.subCategoryName,
          ),
        )
        .toList();
  }
}
