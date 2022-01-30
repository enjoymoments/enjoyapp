import 'package:custom_utilities/custom_utilities.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/session_model.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/features/places/presentation/blocs/categories_places/categories_places_state.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class CategoriesPlacesCubit extends Cubit<CategoriesPlacesState> {
  CategoriesPlacesCubit() : super(CategoriesPlacesState.initial());

  void loadPrimary(List<PlacesCategory> places) {
    var _categoryInitial = places[0];

    emit(
      state.copyWith(
        interestSelected: _getInterests(_categoryInitial),
        //TOOD:in development
        //sessions: _getSessions(_categoryInitial),
        places: places,
        categorySelected: _categoryInitial,
        contentPlaces:
            _categoryInitial.subCategories![0].places as List<PlaceModel?>?,
        contentSuggestedByUsers: _categoryInitial
            .subCategories![0].suggestedByUsers as List<SuggestionsModel?>?,
      ),
    );
  }

  void categorySelected(PlacesCategory category) {
    emit(
      state.copyWith(
        categorySelected: category,
        contentPlaces: category.subCategories![0].places as List<PlaceModel?>?,
        contentSuggestedByUsers: category.subCategories![0].suggestedByUsers
            as List<SuggestionsModel?>?,
        interestSelected: _getInterests(category),
        //TOOD:in development
        //sessions: _getSessions(category),
      ),
    );
  }

  void subCategorySelected(
      InterestEnum? interestSelected, List<dynamic>? data) {
    if (interestSelected == InterestEnum.Place) {
      emit(state.copyWith(contentPlaces: data as List<PlaceModel?>?));
    } else if (interestSelected == InterestEnum.SuggestedByUsers) {
      emit(state.copyWith(
          contentSuggestedByUsers: data as List<SuggestionsModel?>?));
    }
  }

  void selectedSession(SessionModel item) {
    List<SessionModel> _list = state.sessions!.map((e) {
      e.selected = e.type == item.type;
      return e;
    }).toList();

    emit(
      state.copyWith(sessions: _list, interestSelected: item.type),
    );
  }

  List<Widget> buildTabsTitle(PlacesCategory category) {
    return category.subCategories!
        .map(
          (e) => Tab(
            text: e.subCategoryName,
          ),
        )
        .toList();
  }

  //TOOD:in development
  // List<SessionModel> _loadSessions() {
  //   if (state.sessions.length == 0) {
  //     return [
  //       SessionModel(
  //           type: InterestEnum.Place, selected: false, text: 'Lugares'),
  //       SessionModel(
  //           type: InterestEnum.SuggestedByUsers,
  //           selected: false,
  //           text: 'Sugerido'),
  //     ];
  //   }

  //   return state.sessions;
  // }

  InterestEnum _getInterests(PlacesCategory category) {
    return InterestEnum.SuggestedByUsers;

    //TOOD:in development
    // if (category.subCategories[0].places.length > 0 &&
    //     category.subCategories[0].suggestedByUsers.length > 0) {
    //   return InterestEnum.SuggestedByUsers;
    // } else if (category.subCategories[0].places.length > 0) {
    //   return InterestEnum.Place;
    // } else if (category.subCategories[0].suggestedByUsers.length > 0) {
    //   return InterestEnum.SuggestedByUsers;
    // }

    // return null;
  }

  //TOOD:in development
  // List<SessionModel> _getSessions(PlacesCategory category) {
  //   if (category.subCategories[0].places.length > 0 &&
  //       category.subCategories[0].suggestedByUsers.length > 0) {
  //     return _loadSessions();
  //   }

  //   return <SessionModel>[];
  // }
}
