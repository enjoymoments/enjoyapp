part of 'places_bloc.dart';

class PlacesState extends DefaultState {
  PlacesState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.model,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final PlacesModel model;

  factory PlacesState.initial() {
    return PlacesState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      model: PlacesModel(),
    );
  }

  PlacesState copyWith({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    PlacesModel model,
  }) {
    return PlacesState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      model: model ?? this.model,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    isEmpty,
    isError,
    isSuccess,
    errorMessage,
    model,
  ];
}
