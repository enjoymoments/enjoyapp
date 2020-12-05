import 'package:dartz/dartz.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/places_model.dart';

abstract class PlacesRepository {
  Future<Either<PlacesModel, Exception>> getPlaces(
    double latitude,
    double longitude,
    int radius,
    String type,
  );

  Future<Either<PlaceModel, Exception>> getPlaceDetails(
    PlaceModel place,
  );
}
