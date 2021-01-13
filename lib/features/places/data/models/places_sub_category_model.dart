import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places_sub_category.dart';

class PlacesSubCategoryModel extends PlacesSubCategory {
  PlacesSubCategoryModel({List<PlaceModel> data, String subCategoryName})
      : super(
          data: data,
          subCategoryName: subCategoryName,
        );

  factory PlacesSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return PlacesSubCategoryModel(
      subCategoryName: json['subCategoryName'],
      data: List<PlaceModel>.from(
        json["data"].map((x) => PlaceModel.fromJson(x)),
      ),
    );
  }
}
