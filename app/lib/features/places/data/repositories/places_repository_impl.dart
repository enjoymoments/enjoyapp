import 'package:dartz/dartz.dart';
import 'package:mozin/features/places/data/datasources/places_remote_data_source.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
import 'package:custom_utilities/custom_utilities.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl({
    required this.remoteDataSource,
  });

  final PlacesRemoteDataSource? remoteDataSource;

  @override
  Future<Either<PlacesModel, Exception>> getPlaces(
    double latitude,
    double longitude,
    FilterChoosedModel? filters,
  ) async {
    try {
      var response =
          await remoteDataSource!.getPlaces(latitude, longitude, filters);
      return Left<PlacesModel, Exception>(response);
    } catch (e) {
      return Right<PlacesModel, Exception>(ExceptionsUtils.createException(e));
    }
  }

  @override
  Future<Either<PlaceModel, Exception>> getPlaceDetails(
      PlaceModel? place) async {
    try {
      var response = await remoteDataSource!.getPlaceDetails(place);
      return Left<PlaceModel, Exception>(response);
    } catch (e) {
      return Right<PlaceModel, Exception>(ExceptionsUtils.createException(e));
    }
  }

  @override
  Future<String?> getPlacePhoto(String? placeId, String photoReference) async {
    try {
      return remoteDataSource!.getPlacePhoto(placeId, photoReference);
    } catch (e) {
      return Future.value(null);
    }
  }
}
