import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc({
    required PlacesRepository placesRepository,
    required FilterChoosedWrapper filterChoosedWrapper,
  })  : _placesRepository = placesRepository,
        _filterChoosedWrapper = filterChoosedWrapper,
        super(PlacesState.initial());

  final PlacesRepository _placesRepository;
  final FilterChoosedWrapper _filterChoosedWrapper;

  @override
  Stream<PlacesState> mapEventToState(
    PlacesEvent event,
  ) async* {
    if (event is GetCurrentPosition) {
      yield* mapGetCurrentPositionToState();
    }
  }

  Stream<PlacesState> mapGetCurrentPositionToState() async* {
    try {
      yield state.copyWith(isLoading: true, isError: false);

      var _existPermission = await Geolocator.checkPermission();

      if (_existPermission == LocationPermission.denied ||
          _existPermission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      Either<PlacesModel, Exception> response =
          await _placesRepository.getPlaces(position.latitude,
              position.longitude, _filterChoosedWrapper.getFilterChoosed);

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

  //TODO:for test
  // Stream<PlacesState> mapGetCurrentPositionToState(
  //     FilterChoosedModel filterChoosed) async* {
  //   try {
  //     yield state.copyWith(isLoading: true, isError: false);

  //     // Position position = await Geolocator.getCurrentPosition(
  //     //     desiredAccuracy: LocationAccuracy.best);

  //     Either<PlacesModel, Exception> response =
  //         await _placesRepository.getPlaces(
  //             -23.6322975 //position.latitude
  //             ,
  //             -46.6395946 //,position.longitude
  //             ,
  //             filterChoosed);

  //     yield response.fold((model) {
  //       return state.copyWith(
  //           isLoading: false, isError: false, isSuccess: true, model: model);
  //     }, (error) {
  //       return state.copyWith(
  //           isLoading: false, isError: true, isSuccess: false);
  //     });
  //   } on TimeoutException {
  //     yield state.copyWith(isLoading: false, isError: true, errorMessage: '');
  //   } on PermissionDeniedException {
  //     yield state.copyWith(isLoading: false, isError: true, errorMessage: '');
  //   } on LocationServiceDisabledException {
  //     yield state.copyWith(isLoading: false, isError: true, errorMessage: '');
  //   } catch (e) {
  //     yield state.copyWith(isLoading: false, isError: true);
  //   }
  // }
}
