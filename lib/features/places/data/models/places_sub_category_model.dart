import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places_sub_category.dart';

class PlacesSubCategoryModel extends PlacesSubCategory {
  PlacesSubCategoryModel({
    List<PlaceModel> data,
    String subCategoryName,
    String subCategoryId,
  }) : super(
          data: data,
          subCategoryName: subCategoryName,
          subCategoryId: subCategoryId,
        );

  factory PlacesSubCategoryModel.fromJson(String categoryId, String categoryName, Map<String, dynamic> json) {
    return PlacesSubCategoryModel(
      subCategoryId: json['subCategoryId'],
      subCategoryName: json['subCategoryName'],
      data: List<PlaceModel>.from(
        json["data"].map((x) => PlaceModel.fromJson(categoryId, categoryName, json['subCategoryId'], json['subCategoryName'], x)),
      ),
    );
  }
}
