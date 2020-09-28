import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/models/user_app_model.dart';
import 'package:mozin/modules/user/services/user_service.dart';
import 'package:mozin/push_notification_config.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/shared/blocs/default_state.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, DefaultState> {
  AuthenticationBloc(this._authenticationRepository, this._userService,
      this._pushNotificationConfig)
      : super(AuthenticationInitial());

  final AuthenticationRepository _authenticationRepository;
  final UserService _userService;
  final PushNotificationConfig _pushNotificationConfig;

  @override
  Stream<DefaultState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is RequestGoogleLogin) {
      yield* mapLogInWithGoogleToState(event);
    } else if (event is Logout) {
      yield* mapLogoutToState();
    } else if (event is CheckAuthenticated) {
      yield* mapCheckAuthenticatedToState();
    }
  }

  Stream<DefaultState> mapCheckAuthenticatedToState() async* {
    try {
      yield Loading();

      if (!_authenticationRepository.isAuthenticated()) {
        yield Unauthenticated();
        return;
      }

      yield AuthenticationSuccess(getItInstance<UserAppModel>());
    } catch (e) {
      yield Error(error: 'Ops');
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

      final _token = await _pushNotificationConfig.configureAsync();

      this
          ._userService
          .setTokensPushNotifications(_user.id, _user.email, _token);

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
