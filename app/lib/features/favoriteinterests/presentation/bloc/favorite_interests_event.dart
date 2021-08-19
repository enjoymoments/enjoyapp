import 'package:equatable/equatable.dart';
import 'package:mozin/features/places/data/models/place_model.dart';

abstract class FavoriteInterestsEvent extends Equatable {
  const FavoriteInterestsEvent();
  @override
  List<Object> get props => <Object>[];
}

class AddPlaceToFavorite extends FavoriteInterestsEvent {
  final PlaceModel place;

  AddPlaceToFavorite(
    this.place,
  );
}

class SetFavoriteItem extends FavoriteInterestsEvent {
  final bool favoriteAdded;

  SetFavoriteItem(this.favoriteAdded);
}

class LoadFavoriteInterests extends FavoriteInterestsEvent {}