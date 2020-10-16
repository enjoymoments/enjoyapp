import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  InterestBloc({@required InterestRepository interestRepository})
      : assert(interestRepository != null),
        _interestRepository = interestRepository,
        super(InterestState.initial());

  final InterestRepository _interestRepository;

  @override
  Stream<InterestState> mapEventToState(
    InterestEvent event,
  ) async* {
  }
}