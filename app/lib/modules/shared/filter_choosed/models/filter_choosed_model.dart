import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/general_filters_model.dart';

class FilterChoosedModel {
  final List<CategoriesModel> categories;
  final GeneralFilterModel generalFilters;

  factory FilterChoosedModel.initial() {
    return FilterChoosedModel(
      categories: List(),
      generalFilters: GeneralFilterModel(
        minPrice: 1.0,
        minDistance: 1.0,
        minTime: 1.0,
        maxPrice: 2.0,
        maxDistance: 5.0,
        maxTime: 2.0,
      ),
    );
  }

  FilterChoosedModel({this.categories, this.generalFilters});

  void changePrice(double minPrice, double maxPrice) {
    generalFilters.minPrice = minPrice;
    generalFilters.maxPrice = maxPrice;
  }

  void changeDistance(double minDistance, double maxDistance) {
    generalFilters.minDistance = minDistance;
    generalFilters.maxDistance = maxDistance;
  }

  void changeTime(double minTime, double maxTime) {
    generalFilters.minTime = minTime;
    generalFilters.maxTime = maxTime;
  }

  void insertCategorie(CategoriesModel item) {
    categories.add(item);
  }

  void removeCategorie(CategoriesModel item) {
    categories.remove(item);
  }

  void insertSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    CategoriesModel categorieFilter =
        categories.firstWhere((element) => element.id == categorie.id);
    SubCategoriesModel subCategorieFilter = categorieFilter.subCategories
        .firstWhere((element) => element.id == item.id);
    subCategorieFilter.selected = true;
  }

  void removeSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    CategoriesModel categorieFilter =
        categories.firstWhere((element) => element.id == categorie.id);
    SubCategoriesModel subCategorieFilter = categorieFilter.subCategories
        .firstWhere((element) => element.id == item.id);
    subCategorieFilter.selected = false;
  }

  Map<String, dynamic> toJson(List<dynamic> _categories) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['generalFilters'] = this.generalFilters.toJson();
    data['categories'] = _categories;

    return data;
  }

  factory FilterChoosedModel.fromJson(Map<String, dynamic> json) {
    var listCategories = <CategoriesModel>[];

    if (json['categories'] != null) {
      json['categories'].forEach((dynamic v) {
        listCategories.add(CategoriesModel.fromJson(v));
      });
    }

    return FilterChoosedModel(
      generalFilters: GeneralFilterModel.fromJson(json['generalFilters']),
      categories: listCategories,
    );
  }
}
