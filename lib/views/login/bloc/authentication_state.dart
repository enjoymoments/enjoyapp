part of 'authentication_bloc.dart';

class AuthenticationInitial extends DefaultState {}

class AuthenticationSuccess extends DefaultState {
  final User user;

  AuthenticationSuccess(this.user);
}

class LogoutSuccess extends DefaultState {}
