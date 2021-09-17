part of 'place_details_bloc.dart';

class PlaceDetailsState extends DefaultState {
  PlaceDetailsState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.item,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final PlaceModel? item;

  factory PlaceDetailsState.initial() {
    return PlaceDetailsState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
    );
  }

  PlaceDetailsState copyWith({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    PlaceModel? item,
  }) {
    return PlaceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      item: item ?? this.item,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        item,
      ];
}
