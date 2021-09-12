import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

class FavoriteInterestsItemState extends DefaultState {
  FavoriteInterestsItemState({
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

  factory FavoriteInterestsItemState.initial() {
    return FavoriteInterestsItemState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      forceRefresh: null,
      favoriteAdded: false,
    );
  }

  FavoriteInterestsItemState copyWith({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    int forceRefresh,
    bool favoriteAdded,
  }) {
    return FavoriteInterestsItemState(
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
