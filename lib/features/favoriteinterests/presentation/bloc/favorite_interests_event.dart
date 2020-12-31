import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/enums.dart';

abstract class FavoriteInterestsEvent extends Equatable {
  const FavoriteInterestsEvent();
  @override
  List<Object> get props => <Object>[];
}

class AddFavoriteInterestEvent extends FavoriteInterestsEvent {
  final String interestId;
  final InterestEnum interestType;

  AddFavoriteInterestEvent(this.interestId, this.interestType);
}

