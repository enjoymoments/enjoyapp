part of 'interest_bloc.dart';

abstract class InterestEvent extends Equatable {
  const InterestEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadCategories extends InterestEvent {}

class SelectCategorie extends InterestEvent {
  final CategoriesModel itemSelected;
  final bool selected;

  SelectCategorie({
    @required this.itemSelected,
    @required this.selected,
  });
}

class SelectSubCategorie extends InterestEvent {
  final CategoriesModel categorie;
  final SubCategoriesModel itemSelected;
  final bool selected;

  SelectSubCategorie({
    @required this.itemSelected,
    @required this.selected,
    @required this.categorie,
  });
}

class ChangePrice extends InterestEvent {
  final double minPrice;
  final double maxPrice;

  ChangePrice({@required this.minPrice, @required this.maxPrice});
}

class ChangeDistance extends InterestEvent {
  final double minDistance;
  final double maxDistance;

  ChangeDistance({@required this.minDistance, @required this.maxDistance});
}

class ChangeTime extends InterestEvent {
  final double minTime;
  final double maxTime;

  ChangeTime({@required this.minTime, @required this.maxTime});
}
