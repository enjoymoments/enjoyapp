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
