import 'package:mozin/features/interest/data/models/categories_model.dart';

class FilterChoosedModel {
  List<CategoriesModel> _categories;

  factory FilterChoosedModel.initial() {
    return FilterChoosedModel(
      categories: List(),
    );
  }

  FilterChoosedModel({
    List<CategoriesModel> categories,
  }) {
    _categories = categories;
  }

  void insertCategorie(CategoriesModel item) {
    _categories.add(item);
  }

  void removeCategorie(CategoriesModel item) {
    _categories.remove(item);
  }
}
