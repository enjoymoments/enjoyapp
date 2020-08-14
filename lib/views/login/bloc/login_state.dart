part of 'login_bloc.dart';

class LoginInitial extends DefaultState {}

class LoginSuccess extends DefaultState {
  final User user;

  LoginSuccess(this.user);
}
