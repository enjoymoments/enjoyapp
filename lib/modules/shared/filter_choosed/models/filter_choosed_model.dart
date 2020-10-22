import 'package:mozin/features/interest/data/models/categories_model.dart';

class FilterChoosedModel {
  final List<CategoriesModel> categories;

  factory FilterChoosedModel.initial() {
    return FilterChoosedModel(
      categories: List(),
    );
  }

  FilterChoosedModel({
    this.categories,
  });

  void insertCategorie(CategoriesModel item) {
    categories.add(item);
  }

  void removeCategorie(CategoriesModel item) {
    categories.remove(item);
  }
}
