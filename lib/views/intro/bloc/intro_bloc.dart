import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/config/constants.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, DefaultState> {
  IntroBloc(LocalStorageService localStorageService)
      : assert(localStorageService != null),
        _localStorageService = localStorageService,
        super(IntroInitial());

  LocalStorageService _localStorageService;

  @override
  Stream<DefaultState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is VerifyScreen) {
      yield* mapVerifyToState();
    }
  }

  Stream<DefaultState> mapVerifyToState() async* {
    yield Loading();

    if (_localStorageService.containsKey(bypass_onboarding_screen)) {
      yield RedirectHome();
      return;
    }

    _localStorageService.put(KeyValue<String, String>(
        key: bypass_onboarding_screen, value: bypass_onboarding_screen));
    yield RedirectOnboarding();
  }
}
