import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/me/domain/repositories/me_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'me_event.dart';
part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  MeBloc({@required MeRepository meRepository})
      : assert(meRepository != null),
        _meRepository = meRepository,
        super(MeState.initial());

  final MeRepository _meRepository;

  @override
  Stream<MeState> mapEventToState(
    MeEvent event,
  ) async* {
  }
}