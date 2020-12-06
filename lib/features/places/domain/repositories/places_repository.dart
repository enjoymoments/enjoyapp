import 'package:dartz/dartz.dart';
import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/data/models/places_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';

abstract class PlacesRepository {
  Future<Either<PlacesModel, Exception>> getPlaces(
    double latitude,
    double longitude,
    FilterChoosedModel filters,
  );

  Future<Either<PlaceModel, Exception>> getPlaceDetails(
    PlaceModel place,
  );

  Future<String> getPlacePhoto(String photoReference);
}
