import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/models/user.dart';
import 'package:mozin/views/shared/bloc/default_state.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, DefaultState> {
  LoginBloc(this._authenticationRepository) : super(LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<DefaultState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is RequestGoogleLogin) {
      yield* mapGoogleLoginToState(event);
    }
  }

  Stream<DefaultState> mapGoogleLoginToState(
    RequestGoogleLogin event,
  ) async* {
    yield Loading();

    try {
      await _authenticationRepository.logInWithGoogle();
      final _user = await _authenticationRepository.user.first;
      yield LoginSuccess(_user);
    } catch (e) {
      yield Error(error: 'Ops');
    }
  }
}
