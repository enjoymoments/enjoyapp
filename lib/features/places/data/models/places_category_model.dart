import 'package:mozin/features/places/data/models/places_sub_category_model.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';

class PlacesCategoryModel extends PlacesCategory {
  PlacesCategoryModel({
    List<PlacesSubCategoryModel> subCategories,
    String categoryName,
    String categoryId,
  }) : super(
          subCategories: subCategories,
          categoryName: categoryName,
          categoryId: categoryId,
        );

  factory PlacesCategoryModel.fromJson(Map<String, dynamic> json) {
    return PlacesCategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      subCategories: List<PlacesSubCategoryModel>.from(
        json["subCategories"].map((x) => PlacesSubCategoryModel.fromJson(json['categoryId'], x)),
      ),
    );
  }
}
