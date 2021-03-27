part of 'interest_bloc.dart';

class InterestState extends DefaultState {
  InterestState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.categories,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<CategoriesModel> categories;
  final int forceRefresh;

  factory InterestState.initial() {
    return InterestState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      categories: List(),
      forceRefresh: null,
    );
  }

  InterestState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<CategoriesModel> categories,
    int forceRefresh,
  }) {
    return InterestState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      forceRefresh: forceRefresh ?? this.forceRefresh,
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
        forceRefresh,
      ];
}
