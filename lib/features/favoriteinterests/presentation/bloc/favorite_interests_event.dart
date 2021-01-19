import 'package:equatable/equatable.dart';

abstract class FavoriteInterestsEvent extends Equatable {
  const FavoriteInterestsEvent();
  @override
  List<Object> get props => <Object>[];
}

class AddPlaceToFavorite extends FavoriteInterestsEvent {
  final String categoryId;
  final String subCategoryId;
  final dynamic data;

  AddPlaceToFavorite(
    this.categoryId,
    this.subCategoryId,
    this.data,
  );
}

class SetFavoriteItem extends FavoriteInterestsEvent {
  final bool favoriteAdded;

  SetFavoriteItem(this.favoriteAdded);
}
