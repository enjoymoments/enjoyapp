import 'package:equatable/equatable.dart';

abstract class FavoriteInterestsEvent extends Equatable {
  const FavoriteInterestsEvent();
  @override
  List<Object> get props => <Object>[];
}

class LoadFavoriteInterests extends FavoriteInterestsEvent {}
