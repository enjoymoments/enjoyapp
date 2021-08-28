import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places_sub_category.dart';

class PlacesSubCategoryModel extends PlacesSubCategory {
  PlacesSubCategoryModel({
    List<PlaceModel> places,
    String subCategoryName,
    String subCategoryId,
  }) : super(
          places: places,
          subCategoryName: subCategoryName,
          subCategoryId: subCategoryId,
        );

  factory PlacesSubCategoryModel.fromJson(String categoryId, String categoryName, Map<String, dynamic> json) {
    return PlacesSubCategoryModel(
      subCategoryId: json['subCategoryId'],
      subCategoryName: json['subCategoryName'],
      places: List<PlaceModel>.from(
        json["places"].map((x) => PlaceModel.fromJson(categoryId, categoryName, json['subCategoryId'], json['subCategoryName'], x)),
      ),
    );
  }
}
