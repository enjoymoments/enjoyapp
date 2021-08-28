import 'package:mozin/features/places/data/models/place_model.dart';
import 'package:mozin/features/places/domain/entities/places_sub_category.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';

class PlacesSubCategoryModel extends PlacesSubCategory {
  PlacesSubCategoryModel({
    List<PlaceModel> places,
    List<SuggestionsModel> suggestedByUsers,
    String subCategoryName,
    String subCategoryId,
  }) : super(
          places: places,
          suggestedByUsers: suggestedByUsers,
          subCategoryName: subCategoryName,
          subCategoryId: subCategoryId,
        );

  factory PlacesSubCategoryModel.fromJson(
      String categoryId, String categoryName, Map<String, dynamic> json) {
    return PlacesSubCategoryModel(
      subCategoryId: json['subCategoryId'],
      subCategoryName: json['subCategoryName'],
      places: json["places"] != null
          ? List<PlaceModel>.from(
              json["places"].map((x) => PlaceModel.fromJson(
                  categoryId,
                  categoryName,
                  json['subCategoryId'],
                  json['subCategoryName'],
                  x)),
            )
          : [],
      suggestedByUsers: json["suggestedByUsers"] != null
          ? List<SuggestionsModel>.from(
              json["suggestedByUsers"].map((x) => SuggestionsModel.fromJson(
                  categoryId,
                  categoryName,
                  json['subCategoryId'],
                  json['subCategoryName'],
                  x)),
            )
          : [],
    );
  }
}
