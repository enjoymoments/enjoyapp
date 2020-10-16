import 'package:mozin/features/places/data/datasources/places_remote_data_source.dart';
import 'package:mozin/features/places/domain/repositories/places_repository.dart';
import 'package:flutter/material.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl({
    @required this.remoteDataSource,
  });

  final PlacesRemoteDataSource remoteDataSource;
}
