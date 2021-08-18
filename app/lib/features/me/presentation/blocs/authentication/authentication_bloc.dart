import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/screen_manager/presentation/bloc/screen_manager_bloc.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.initial()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  AuthenticationRepository get _authenticationRepository => getItInstance<AuthenticationRepository>();
  UserService get _userService => getItInstance<UserService>();
  PushNotificationConfig get _pushNotificationConfig => getItInstance<PushNotificationConfig>();
  UserWrapper get _userWrapper => getItInstance<UserWrapper>();

  StreamSubscription<UserAppModel> _userSubscription;

  bool _settingsExecute = false;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      _mapAuthenticationUserChangedToState(event);
    } else if (event is RequestGoogleLogin) {
      yield* mapLogInWithGoogleToState(event);
    } else if (event is RequestFacebookLogin) {
      yield* mapLogInWithFacebookToState(event);
    } else if (event is RequestAppleLogin) {
      yield* mapLogInWithAppleToState(event);
    } else if (event is Logout) {
      yield* mapLogoutToState();
    } else if (event is CheckAuthenticated) {
      yield* mapCheckAuthenticatedToState();
    } else if (event is CloseOnboardScreen) {
      yield* mapCloseOnboardScreenToState();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<AuthenticationState> mapCheckAuthenticatedToState() async* {
    try {
      await Future<void>.delayed(Duration(milliseconds: 350));

      yield state.copyWith(isLoading: true);

      var _user = _userWrapper.getUser;

      if (_user != UserAppModel.empty) {
        yield state.copyWith(isLoading: false, authenticated: true);
        return;
      }

      yield state.copyWith(isLoading: false, authenticated: false);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

    Stream<AuthenticationState> mapLogInWithAppleToState(
    RequestAppleLogin event,
  ) async* {
    try {
      yield state.copyWith(isLoading: true);

      await _authenticationRepository.logInWithApple();

      final _user = await _authenticationRepository.user.first;

      _userWrapper.assignment(_user);

      _settingsUser(_user);

      yield state.copyWith(isLoading: false, user: _user);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  Stream<AuthenticationState> mapLogInWithFacebookToState(
    RequestFacebookLogin event,
  ) async* {
    try {
      yield state.copyWith(isLoading: true);

      await _authenticationRepository.logInWithFacebook();

      final _user = await _authenticationRepository.user.first;

      _userWrapper.assignment(_user);

      _settingsUser(_user);

      yield state.copyWith(isLoading: false, user: _user);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  Stream<AuthenticationState> mapLogInWithGoogleToState(
    RequestGoogleLogin event,
  ) async* {
    try {
      yield state.copyWith(isLoading: true);

      await _authenticationRepository.logInWithGoogle();

      final _user = await _authenticationRepository.user.first;

      _userWrapper.assignment(_user);

      _settingsUser(_user);

      yield state.copyWith(isLoading: false, user: _user);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  Stream<AuthenticationState> mapLogoutToState() async* {
    try {
      await _authenticationRepository.logOut();
      await resetInstances();

      yield state.copyWith(isLoading: false, authenticated: false);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

    Stream<AuthenticationState> mapCloseOnboardScreenToState() async* {
    try {
      yield state.copyWith(closeOnboardingScreen: true);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  void _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event) async {
    _userWrapper.assignment(event.user);

    //_settingsExecute - avoids running too often
    if (_settingsExecute == false && event.user != UserAppModel.empty) {
      getItInstance<ScreenManagerBloc>()..add(SubscribeActionListener());
      _settingsUser(event.user);
      _settingsExecute = true;
    }

    this.add(CheckAuthenticated());
  }

  void _settingsUser(UserAppModel user) async {
    final _token = await _pushNotificationConfig.configureAsync();

    _userService.setTokensPushNotifications(user, _token);
    _userService.getFavoriteInterests();
    _userService.setActionListener(user);
    _userService.setUserInfo().then((response) {
      response.fold((model) {
        if(model != null) {
          _userWrapper.setInternalId(model.userInternalId);
          _userWrapper.setCoupleId(model.coupleId);
        }
      }, (error) => null);
    });
  }
}
