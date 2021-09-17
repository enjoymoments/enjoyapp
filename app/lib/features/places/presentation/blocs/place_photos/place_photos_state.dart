part of 'place_photos_bloc.dart';

class PlacePhotosState extends DefaultState {
  PlacePhotosState({
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

  factory PlacePhotosState.initial() {
    return PlacePhotosState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
    );
  }

  PlacePhotosState copyWith({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    PlaceModel? item,
  }) {
    return PlacePhotosState(
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
