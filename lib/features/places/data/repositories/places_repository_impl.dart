import 'package:dartz/dartz.dart';
import 'package:mozin/features/places/data/datasources/places_remote_data_source.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:flutter/material.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl({
    @required this.remoteDataSource,
  });

  final PlacesRemoteDataSource remoteDataSource;

  @override
  Future<Either<PlacesModel, Exception>> getPlaces(
    double latitude,
    double longitude,
    int radius,
    String type,
  ) async {
    try {
      var response =
          await remoteDataSource.getPlaces(latitude, longitude, radius, type);
      return Left<PlacesModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<PlacesModel, Exception>(Exception('error'));
    }
  }
}
