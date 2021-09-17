import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/more/domain/repositories/more_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreBloc({required MoreRepository moreRepository})
      : assert(moreRepository != null),
        _moreRepository = moreRepository,
        super(MoreState.initial());

  final MoreRepository _moreRepository;

  @override
  Stream<MoreState> mapEventToState(
    MoreEvent event,
  ) async* {
  }
}