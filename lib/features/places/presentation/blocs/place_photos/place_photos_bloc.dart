import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'place_photos_event.dart';
part 'place_photos_state.dart';

class PlacePhotosBloc extends Bloc<PlacePhotosEvent, PlacePhotosState> {
  PlacePhotosBloc({@required PlacesRepository placesRepository})
      : assert(placesRepository != null),
        _placesRepository = placesRepository,
        super(PlacePhotosState.initial());

  final PlacesRepository _placesRepository;

  @override
  Stream<PlacePhotosState> mapEventToState(
    PlacePhotosEvent event,
  ) async* {
    if (event is LoadPhotos) {
      yield* mapPhotosToState(event);
    }
  }

  Stream<PlacePhotosState> mapPhotosToState(LoadPhotos event) async* {
    List<Future<String>> _listFutures = List<Future<String>>();
    List<Uint8List> _listPhotos = List<Uint8List>();

    for (var photoReference in event.item.photoReferences) {
      _listFutures.add(
        _placesRepository.getPlacePhoto(photoReference).then(
          (String value) {
            if (value != null) {
              var image = base64.decode(value);
              _listPhotos.add(image);
            }
          },
        ),
      );
    }

    await Future.wait(_listFutures);

    event.item.photos = _listPhotos;

    yield state.copyWith(item: event.item);
  }
}
