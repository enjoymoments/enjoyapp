import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'categories_places_state.dart';

class CategoriesPlacesCubit extends Cubit<CategoriesPlacesState> {
  CategoriesPlacesCubit() : super(CategoriesPlacesState.initial());

  void loadPrimary(List<PlacesCategory> places) {
    emit(state.copyWith(places: places));

    var _categoryInitial = places[0];
    emit(state.copyWith(
        categorySelected: _categoryInitial,
        tabsTitle: _buildTabsTitle(_categoryInitial)));

    emit(state.copyWith(content: _categoryInitial.subCategories[0].data));
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
