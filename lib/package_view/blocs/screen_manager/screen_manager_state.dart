part of 'screen_manager_bloc.dart';

class ScreenManagerState extends Equatable {
  
  final bool isLoading;
  final List<GalleryImageModel> medias;
  final bool isSuccess;
  final bool isFailure;
  final DEFAULT_MENU_ENUM currentScreen;

  ScreenManagerState({
    this.isLoading,
    this.medias,
    this.isSuccess,
    this.isFailure,
    this.currentScreen,
  });

  factory ScreenManagerState.initial() {
    return ScreenManagerState(
      isLoading: false,
      medias: List(),
      isSuccess: false,
      isFailure: false,
      currentScreen: DEFAULT_MENU_ENUM.HOME,
    );
  }

  ScreenManagerState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    List<GalleryImageModel> medias,
    DEFAULT_MENU_ENUM currentScreen,
  }) {
    return ScreenManagerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      medias: medias ?? this.medias,
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        medias,
        currentScreen,
      ];
}
