part of 'screen_manager_bloc.dart';

class ScreenManagerState extends Equatable {
  
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final DefaultMenuEnum currentScreen;
  final Map<DefaultMenuEnum, Widget> contents;

  ScreenManagerState({
    this.isLoading,
    this.isSuccess,
    this.isFailure,
    this.currentScreen,
    this.contents,
  });

  factory ScreenManagerState.initial() {
    return ScreenManagerState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      currentScreen: DefaultMenuEnum.TimeLine,
      contents: {
        DefaultMenuEnum.TimeLine: TimeLineScreen(),
      },
    );
  }

  ScreenManagerState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    DefaultMenuEnum currentScreen,
    Map<DefaultMenuEnum, Widget> contents,
  }) {
    return ScreenManagerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      currentScreen: currentScreen ?? this.currentScreen,
      contents: contents ?? this.contents,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        currentScreen,
        contents,
      ];
}
