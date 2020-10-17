import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/home/domain/repositories/home_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        _homeRepository = homeRepository,
        super(HomeState.initial());

  final HomeRepository _homeRepository;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
  }
}