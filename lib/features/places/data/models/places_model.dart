import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places.dart';

class PlacesModel extends Places {
  PlacesModel({List<PlaceModel> places})
      : super(
          places: places,
        );

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      places: List<PlaceModel>.from(
          json["places"].map((x) => PlaceModel.fromJson(x))),
    );
  }
}
