part of 'categories_places_cubit.dart';

class CategoriesPlacesState extends DefaultState {
  CategoriesPlacesState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.places,
    this.categorySelected,
    this.tabsTitle,
    this.content,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<PlacesCategory> places;
  final PlacesCategory categorySelected;
  final List<Widget> tabsTitle;
  final List<PlaceModel> content;

  factory CategoriesPlacesState.initial() {
    return CategoriesPlacesState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      places: List(),
      categorySelected: null,
      tabsTitle: List(),
      content: List(),
    );
  }

  CategoriesPlacesState copyWith({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    List<PlacesCategory> places,
    PlacesCategory categorySelected,
    List<Widget> tabsTitle,
    List<PlaceModel> content,
  }) {
    return CategoriesPlacesState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      places: places ?? this.places,
      categorySelected: categorySelected ?? this.categorySelected,
      tabsTitle: tabsTitle ?? this.tabsTitle,
      content: content ?? this.content,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        places,
        categorySelected,
        tabsTitle,
        content,
      ];
}
