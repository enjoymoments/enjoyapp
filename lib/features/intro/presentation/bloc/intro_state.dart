part of 'intro_bloc.dart';

class IntroState extends DefaultState {
  IntroState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.redirectHome,
    this.redirectOnboarding,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final bool redirectOnboarding;
  final bool redirectHome;

  factory IntroState.initial() {
    return IntroState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      redirectHome: false,
      redirectOnboarding: false,
    );
  }

  IntroState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    bool redirectOnboarding,
    bool redirectHome,
  }) {
    return IntroState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      redirectOnboarding: redirectOnboarding ?? this.redirectOnboarding,
      redirectHome: redirectHome ?? this.redirectHome,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        redirectOnboarding,
        redirectHome,
      ];
}
