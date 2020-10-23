part of 'interest_bloc.dart';

class InterestState extends DefaultState {
  InterestState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.categories,
    this.categoriesSelected,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<CategoriesModel> categories;
  final List<CategoriesModel> categoriesSelected;

  factory InterestState.initial() {
    return InterestState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      categories: List(),
      categoriesSelected: List(),
    );
  }

  InterestState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<CategoriesModel> categories,
    List<CategoriesModel> categoriesSelected,
  }) {
    return InterestState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      categoriesSelected: categoriesSelected ?? this.categoriesSelected,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        categories,
        categoriesSelected,
      ];
}
