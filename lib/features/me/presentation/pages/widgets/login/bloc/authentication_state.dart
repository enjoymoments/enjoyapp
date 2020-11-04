part of 'authentication_bloc.dart';

class AuthenticationState extends DefaultState {
  AuthenticationState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.unauthenticated,
    this.user,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final bool unauthenticated;
  final UserAppModel user;

  factory AuthenticationState.initial() {
    return AuthenticationState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      unauthenticated: false,
      user: null,
    );
  }

  AuthenticationState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    bool unauthenticated,
    UserAppModel user,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      unauthenticated: unauthenticated ?? this.unauthenticated,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        unauthenticated,
        user,
      ];
}
