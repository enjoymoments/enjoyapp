import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc({@required PlacesRepository placesRepository})
      : assert(placesRepository != null),
        _placesRepository = placesRepository,
        super(PlacesState.initial());

  final PlacesRepository _placesRepository;

  @override
  Stream<PlacesState> mapEventToState(
    PlacesEvent event,
  ) async* {
  }
}