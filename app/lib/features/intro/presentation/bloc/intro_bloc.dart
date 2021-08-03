import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin_core/constants.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc(LocalStorageService localStorageService)
      : assert(localStorageService != null),
        _localStorageService = localStorageService,
        super(IntroState.initial());

  LocalStorageService _localStorageService;

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is VerifyScreen) {
      yield* mapVerifyToState();
    }
  }

  Stream<IntroState> mapVerifyToState() async* {
    yield state.copyWith(isLoading: true);

    if (_localStorageService.containsKey(bypass_onboarding_screen)) {
      yield state.copyWith(isLoading: false, redirectHome: true);
      return;
    }

    _localStorageService.put(KeyValue<String, String>(
        key: bypass_onboarding_screen, value: bypass_onboarding_screen));
    yield state.copyWith(isLoading: false, redirectOnboarding: true);
  }
}
