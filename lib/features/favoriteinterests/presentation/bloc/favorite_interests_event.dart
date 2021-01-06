import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/general/enums.dart';

abstract class FavoriteInterestsEvent extends Equatable {
  const FavoriteInterestsEvent();
  @override
  List<Object> get props => <Object>[];
}

class ChangeFavoriteInterestEvent extends FavoriteInterestsEvent {
  final String interestId;
  final InterestEnum interestType;
  final dynamic data;

  ChangeFavoriteInterestEvent(this.interestId, this.data, this.interestType);
}

class SetFavoriteItem extends FavoriteInterestsEvent {
  final bool favoriteAdded;

  SetFavoriteItem(this.favoriteAdded);
}
