import 'package:mozin/features/places/domain/enums/place_detail_tabs_enum.dart';
import 'package:custom_utilities/custom_utilities.dart';

class PlaceDetailsTabState extends DefaultState {
  PlaceDetailsTabState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.currentTab,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final PlaceDetailTabsEnum? currentTab;

  factory PlaceDetailsTabState.initial() {
    return PlaceDetailsTabState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      currentTab: PlaceDetailTabsEnum.general,
    );
  }

  PlaceDetailsTabState copyWith({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    PlaceDetailTabsEnum? currentTab,
  }) {
    return PlaceDetailsTabState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        currentTab,
      ];
}
