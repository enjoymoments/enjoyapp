part of 'interest_bloc.dart';

class InterestState extends DefaultState {
  InterestState({this.categories});

  final List<CategoriesModel> categories;

  factory InterestState.initial() {
    return InterestState(
      categories: List(),
    );
  }

  InterestState copyWith({
    List<CategoriesModel> categories,
  }) {
    return InterestState(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [
        categories,
      ];
}
