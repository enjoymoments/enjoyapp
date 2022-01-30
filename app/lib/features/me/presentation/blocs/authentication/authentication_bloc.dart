import 'dart:async';
import 'dart:io';

import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_cubit.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/modules/config/push_notification_config.dart';
import 'package:mozin/modules/config/setup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.initial()) {
    _userSubscription = _authenticationRepository!.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  AuthenticationRepository? get _authenticationRepository =>
      getItInstance<AuthenticationRepository>();

  UserService? get _userService => getItInstance<UserService>();

  PushNotificationConfig? get _pushNotificationConfig =>
      getItInstance<PushNotificationConfig>();
  UserWrapper? get _userWrapper => getItInstance<UserWrapper>();

  StreamSubscription<UserAppModel>? _userSubscription;

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

      var _user = _userWrapper!.getUser;

      if (_user != UserAppModel.empty()) {
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

      await _authenticationRepository!.logInWithApple();

      final _user = await _authenticationRepository!.user.first;

      _assignmentUser(_user);

      await _settingsUser(_user);

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

      await _authenticationRepository!.logInWithFacebook();

      final _user = await _authenticationRepository!.user.first;

      _assignmentUser(_user);

      await _settingsUser(_user);

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

      await _authenticationRepository!.logInWithGoogle();

      final _user = await _authenticationRepository!.user.first;

      _assignmentUser(_user);

      await _settingsUser(_user);

      yield state.copyWith(isLoading: false, user: _user);
    } catch (e) {
      yield state.copyWith(
          isLoading: false, isError: true, errorMessage: 'Ops');
    }
  }

  Stream<AuthenticationState> mapLogoutToState() async* {
    try {
      _settingsExecute = false;
      await _authenticationRepository!.logOut();
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

  void _assignmentUser(UserAppModel user) {
    _userWrapper!.assignment(user, copyWith: true);
  }

  void _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event) async {
    _assignmentUser(event.user);

    //_settingsExecute - avoids running too often
    if (_settingsExecute == false && event.user != UserAppModel.empty()) {
      await _settingsUser(event.user);
      _settingsExecute = true;
    }

    this.add(CheckAuthenticated());
  }

  Future<void> _settingsUser(UserAppModel user) async {
    await _userService!.createUserInFirestore(user);
    await getItInstance<UserInfoCubit>().setUserInfo();

    //TODO:in development
    if (Platform.isAndroid) {
      _pushNotificationConfig!.configureAsync().then((value) {
        _userService!.setTokensPushNotifications(user, value);
      });
    }

    _userService!.setActionListener();
  }
}
