import 'package:mozin/package_view/blocs/default_state.dart';

class FavoriteInterestsState extends DefaultState {
  FavoriteInterestsState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final int forceRefresh;

  factory FavoriteInterestsState.initial() {
    return FavoriteInterestsState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      forceRefresh: null,
    );
  }

  FavoriteInterestsState copyWith({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    int forceRefresh,
  }) {
    return FavoriteInterestsState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      forceRefresh: forceRefresh ?? this.forceRefresh,
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
      ];
}
