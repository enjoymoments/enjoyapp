import 'package:mozin/package_view/blocs/default_state.dart';

class FavoriteInterestsState extends DefaultState {
  FavoriteInterestsState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.forceRefresh,
    this.favoriteAdded,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final int forceRefresh;
  final bool favoriteAdded;

  factory FavoriteInterestsState.initial() {
    return FavoriteInterestsState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      forceRefresh: null,
      favoriteAdded: false,
    );
  }

  FavoriteInterestsState copyWith({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    int forceRefresh,
    bool favoriteAdded,
  }) {
    return FavoriteInterestsState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      forceRefresh: forceRefresh ?? this.forceRefresh,
      favoriteAdded: favoriteAdded ?? this.favoriteAdded,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        forceRefresh,
        favoriteAdded,
      ];
}