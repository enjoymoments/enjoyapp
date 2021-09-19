part of 'suggestions_cubit.dart';

class SuggestionsState extends DefaultState {
  SuggestionsState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.suggestions,
    required this.categories,
    required this.categoriesSelected,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<SuggestionsModel>? suggestions;
  final List<CategoriesModel> categories;
  final Map<String, List<String>> categoriesSelected;
  final int? forceRefresh;

  factory SuggestionsState.initial() {
    return SuggestionsState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      suggestions: [],
      categories: [],
      categoriesSelected: {},
      forceRefresh: null,
    );
  }

  SuggestionsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    List<SuggestionsModel>? suggestions,
    List<CategoriesModel>? categories,
    Map<String, List<String>>? categoriesSelected,
    int? forceRefresh,
  }) {
    return SuggestionsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      suggestions: suggestions ?? this.suggestions,
      categories: categories ?? this.categories,
      categoriesSelected: categoriesSelected ?? this.categoriesSelected,
      forceRefresh: forceRefresh ?? this.forceRefresh,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        suggestions,
        categories,
        categoriesSelected,
        forceRefresh,
      ];
}
