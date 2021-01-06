import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_bloc.dart';
import 'package:mozin/features/favoriteinterests/presentation/bloc/favorite_interests_event.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/features/places/presentation/blocs/place_photos/place_photos_bloc.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'place_details_event.dart';
part 'place_details_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  PlaceDetailsBloc({
    @required PlacesRepository placesRepository,
  })  : assert(placesRepository != null),
        _placesRepository = placesRepository,
        super(PlaceDetailsState.initial());

  final PlacesRepository _placesRepository;

  @override
  Stream<PlaceDetailsState> mapEventToState(
    PlaceDetailsEvent event,
  ) async* {
    if (event is LoadDetails) {
      yield* mapDetailsToState(event);
    }
  }

  Stream<PlaceDetailsState> mapDetailsToState(LoadDetails event) async* {
    yield state.copyWith(isLoading: true, isError: false);

    Either<PlaceModel, Exception> response =
        await _placesRepository.getPlaceDetails(event.item);

    yield response.fold((item) {
      event.item = item;
      event.placePhotosBloc.add(LoadPhotos(event.item));
      event.favoriteInterestsBloc.add(SetFavoriteItem(event.item.favorited));

      return state.copyWith(
          isLoading: false, isError: false, isSuccess: true, item: item);
    }, (error) {
      return state.copyWith(isLoading: false, isError: true, isSuccess: false);
    });
  }
}
