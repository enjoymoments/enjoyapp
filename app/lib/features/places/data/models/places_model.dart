import 'package:mozin/features/places/data/models/places_category_model.dart';
import 'package:mozin/features/places/domain/entities/places.dart';

class PlacesModel extends Places {
  PlacesModel({List<PlacesCategoryModel>? places})
      : super(
          places: places,
        );

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      places: List<PlacesCategoryModel>.from(
          json["places"].map((x) => PlacesCategoryModel.fromJson(x))),
    );
  }
}
