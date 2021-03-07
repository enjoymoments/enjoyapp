part of 'screen_manager_bloc.dart';

class ScreenManagerState extends Equatable {
  
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final DefaultMenuEnum currentScreen;

  ScreenManagerState({
    this.isLoading,
    this.isSuccess,
    this.isFailure,
    this.currentScreen,
  });

  factory ScreenManagerState.initial() {
    return ScreenManagerState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      currentScreen: DefaultMenuEnum.Home,
    );
  }

  ScreenManagerState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    DefaultMenuEnum currentScreen,
  }) {
    return ScreenManagerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        currentScreen,
      ];
}
