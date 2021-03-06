import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';

class FavoriteInterestsState extends DefaultState {
  FavoriteInterestsState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.forceRefresh,
    this.favoriteInterests,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final int? forceRefresh;
  final InterestType? favoriteInterests;

  factory FavoriteInterestsState.initial() {
    return FavoriteInterestsState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      forceRefresh: null,
      favoriteInterests: null,
    );
  }

  FavoriteInterestsState copyWith({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    int? forceRefresh,
    InterestType? favoriteInterests,
  }) {
    return FavoriteInterestsState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      forceRefresh: forceRefresh ?? this.forceRefresh,
      favoriteInterests: favoriteInterests ?? this.favoriteInterests,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        forceRefresh,
        favoriteInterests,
      ];
}
