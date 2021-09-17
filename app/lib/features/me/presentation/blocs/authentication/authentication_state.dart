part of 'authentication_bloc.dart';

class AuthenticationState extends DefaultState {
  AuthenticationState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.closeOnboardingScreen,
    this.authenticated,
    this.user,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final bool? closeOnboardingScreen;
  final bool? authenticated;
  final UserAppModel? user;

  factory AuthenticationState.initial() {
    return AuthenticationState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: true,
      errorMessage: null,
      closeOnboardingScreen: false,
      authenticated: false,
      user: null,
    );
  }

  AuthenticationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    bool? closeOnboardingScreen,
    bool? authenticated,
    UserAppModel? user,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      closeOnboardingScreen: closeOnboardingScreen ?? this.closeOnboardingScreen,
      authenticated: authenticated ?? this.authenticated,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        closeOnboardingScreen,
        authenticated,
        user,
      ];
}
