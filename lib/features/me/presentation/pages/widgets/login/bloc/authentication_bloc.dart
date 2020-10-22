import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authenticationRepository, this._userService,
      this._pushNotificationConfig)
      : super(AuthenticationState.initial()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserService _userService;
  final PushNotificationConfig _pushNotificationConfig;

  StreamSubscription<UserAppModel> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
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

  Stream<AuthenticationState> mapCheckAuthenticatedToState() async* {
    try {
      yield state.copyWith(isLoading: true);

      var _user = getItInstance<UserAppModel>();

      if (_user != UserAppModel.empty) {
        yield state.copyWith(isLoading: false, isSuccess: true);
        return;
      }

      yield state.copyWith(isLoading: false, unauthenticated: true);
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  Stream<AuthenticationState> mapLogInWithGoogleToState(
    RequestGoogleLogin event,
  ) async* {
    try {
      yield state.copyWith(isLoading: true);

      await _authenticationRepository.logInWithGoogle();

      final _user = await _authenticationRepository.user.first;

      getItInstance.registerSingleton(_user);
      _settingsUser(_user);

      yield state.copyWith(isLoading: false, isSuccess: true, user: _user);
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  Stream<AuthenticationState> mapLogoutToState() async* {
    try {
      yield state.copyWith(isLoading: true);

      await _authenticationRepository.logOut();
      await resetInstances();

      yield state.copyWith(isLoading: false, logoutSuccess: true);
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true, errorMessage: 'Ops');
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