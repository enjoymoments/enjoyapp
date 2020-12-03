part of 'place_details_bloc.dart';

class PlaceDetailsState extends DefaultState {
  PlaceDetailsState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.currentTab,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final PlaceDetailTabsEnum currentTab;

  factory PlaceDetailsState.initial() {
    return PlaceDetailsState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      currentTab: PlaceDetailTabsEnum.general,
    );
  }

  PlaceDetailsState copyWith({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    PlaceDetailTabsEnum currentTab,
  }) {
    return PlaceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        currentTab,
      ];
}
