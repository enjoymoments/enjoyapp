import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/models/user_app_model.dart';
import 'package:mozin/modules/user/services/user_service.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/shared/blocs/default_state.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, DefaultState> {
  AuthenticationBloc(this._authenticationRepository, this._userService,)
      : super(AuthenticationInitial());

  final AuthenticationRepository _authenticationRepository;
  final UserService _userService;

  @override
  Stream<DefaultState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is RequestGoogleLogin) {
      yield* mapLogInWithGoogleToState(event);
    } else if (event is Logout) {
      yield* mapLogoutToState();
    }
  }

  Stream<DefaultState> mapLogInWithGoogleToState(
    RequestGoogleLogin event,
  ) async* {
    try {
      yield Loading();

      await _authenticationRepository.logInWithGoogle();
      
      final _user = await _authenticationRepository.user.first;
      getItInstance.registerSingleton(_user);

      yield AuthenticationSuccess(_user);
    } catch (e) {
      yield Error(error: 'Ops');
    }
  }

  Stream<DefaultState> mapLogoutToState() async* {
    try {
      yield Loading();

      await _authenticationRepository.logOut();
      await resetInstances();

      yield LogoutSuccess();
    } catch (e) {
      yield Error(error: 'Ops');
    }
  }
}
