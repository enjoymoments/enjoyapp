import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';

abstract class FavoriteInterestsItemEvent extends Equatable {
  const FavoriteInterestsItemEvent();
  @override
  List<Object> get props => <Object>[];
}

class AddPlaceToFavorite extends FavoriteInterestsItemEvent {
  final PlaceModel place;

  AddPlaceToFavorite(
    this.place,
  );
}

class AddSuggestionToFavorite extends FavoriteInterestsItemEvent {
  final SuggestionsModel suggestion;

  AddSuggestionToFavorite(
    this.suggestion,
  );
}

class SetFavoriteItem extends FavoriteInterestsItemEvent {
  final bool favoriteAdded;

  SetFavoriteItem(this.favoriteAdded);
}
