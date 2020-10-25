part of 'interest_bloc.dart';

class InterestState extends DefaultState {
  InterestState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.categories,
    this.filtersSelected,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<CategoriesModel> categories;
  final FilterChoosedModel filtersSelected;

  factory InterestState.initial() {
    return InterestState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      categories: List(),
      filtersSelected: FilterChoosedModel.initial(),
    );
  }

  InterestState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<CategoriesModel> categories,
    FilterChoosedModel filtersSelected,
  }) {
    return InterestState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      filtersSelected: filtersSelected ?? this.filtersSelected,
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
        filtersSelected,
      ];
}
