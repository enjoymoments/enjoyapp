import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/session_model.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class CategoriesPlacesState extends DefaultState {
  CategoriesPlacesState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.places,
    this.categorySelected,
    this.contentPlaces,
    this.contentSuggestedByUsers,
    this.interestSelected,
    this.sessions,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<PlacesCategory>? places;
  final PlacesCategory? categorySelected;

  //TODO:view this
  final InterestEnum? interestSelected;
  final List<SessionModel>? sessions;

  final List<PlaceModel?>? contentPlaces;
  final List<SuggestionsModel?>? contentSuggestedByUsers;

  factory CategoriesPlacesState.initial() {
    return CategoriesPlacesState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      places: [],
      categorySelected: null,
      contentPlaces: [],
      contentSuggestedByUsers: [],
      sessions: [],
      interestSelected: null,
    );
  }

  CategoriesPlacesState copyWith({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    List<PlacesCategory>? places,
    PlacesCategory? categorySelected,
    List<PlaceModel?>? contentPlaces,
    List<SuggestionsModel?>? contentSuggestedByUsers,
    List<SessionModel>? sessions,
    InterestEnum? interestSelected,
  }) {
    return CategoriesPlacesState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      places: places ?? this.places,
      categorySelected: categorySelected ?? this.categorySelected,
      contentPlaces: contentPlaces ?? this.contentPlaces,
      contentSuggestedByUsers:
          contentSuggestedByUsers ?? this.contentSuggestedByUsers,
      sessions: sessions ?? this.sessions,
      interestSelected: interestSelected ?? this.interestSelected,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        places,
        categorySelected,
        contentPlaces,
        contentSuggestedByUsers,
        sessions,
        interestSelected,
      ];
}
