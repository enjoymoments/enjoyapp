import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
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
    if (event is GetCurrentPosition) {
      yield* mapGetCurrentPositionToState(event.filterChoosed);
    }
  }

  Stream<PlacesState> mapGetCurrentPositionToState(FilterChoosedModel filterChoosed) async* {
    try {
      yield state.copyWith(isLoading: true, isError: false);

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      Either<PlacesModel, Exception> response =
          await _placesRepository.getPlaces(
              position.latitude, position.longitude, filterChoosed);

      yield response.fold((model) {
        return state.copyWith(
            isLoading: false, isError: false, isSuccess: true, model: model);
      }, (error) {
        return state.copyWith(
            isLoading: false, isError: true, isSuccess: false);
      });
    } on TimeoutException {
      yield state.copyWith(isLoading: false, isError: true, errorMessage: '');
    } on PermissionDeniedException {
      yield state.copyWith(isLoading: false, isError: true, errorMessage: '');
    } on LocationServiceDisabledException {
      yield state.copyWith(isLoading: false, isError: true, errorMessage: '');
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }
}
