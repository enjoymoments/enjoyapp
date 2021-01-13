import 'package:mozin/features/places/data/models/places_sub_category_model.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';

class PlacesCategoryModel extends PlacesCategory {
  PlacesCategoryModel(
      {List<PlacesSubCategoryModel> subCategories, String categoryName})
      : super(
          subCategories: subCategories,
          categoryName: categoryName,
        );

  factory PlacesCategoryModel.fromJson(Map<String, dynamic> json) {
    return PlacesCategoryModel(
      categoryName: json['categoryName'],
      subCategories: List<PlacesSubCategoryModel>.from(
        json["subCategories"].map((x) => PlacesSubCategoryModel.fromJson(x)),
      ),
    );
  }
}
