import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/models/user_app_model.dart';
import 'package:mozin/modules/user/services/user_service.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/views/shared/blocs/default_state.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, DefaultState> {
  AuthenticationBloc(this._authenticationRepository, this._userService,
      this._pushNotificationConfig)
      : super(AuthenticationInitial()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserService _userService;
  final PushNotificationConfig _pushNotificationConfig;

  StreamSubscription<UserAppModel> _userSubscription;

  @override
  Stream<DefaultState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      _mapAuthenticationUserChangedToState(event);
    } else if (event is RequestGoogleLogin) {
      yield* mapLogInWithGoogleToState(event);
    } else if (event is Logout) {
      yield* mapLogoutToState();
    } else if (event is CheckAuthenticated) {
      yield* mapCheckAuthenticatedToState();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<DefaultState> mapCheckAuthenticatedToState() async* {
    try {
      yield Loading();

      var _user = getItInstance<UserAppModel>();

      if (_user != UserAppModel.empty) {
        yield AuthenticationSuccess(_user);
        return;
      }

      yield Unauthenticated();
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
      _settingsUser(_user);

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

  void _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event) async {
    getItInstance.registerSingleton(event.user);

    if (event.user != UserAppModel.empty) {
      _settingsUser(event.user);
    }
  }

  void _settingsUser(UserAppModel user) async {
    final _token = await _pushNotificationConfig.configureAsync();

    this._userService.setTokensPushNotifications(user.id, user.email, _token);
  }
}
