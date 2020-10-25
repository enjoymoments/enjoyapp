import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';

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

  void insertSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    CategoriesModel categorieFilter = categories.firstWhere((element) => element.id == categorie.id);
    SubCategoriesModel subCategorieFilter = categorieFilter.subCategories.firstWhere((element) => element.id == item.id);
    subCategorieFilter.selected = true;
  }

  void removeSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    CategoriesModel categorieFilter = categories.firstWhere((element) => element.id == categorie.id);
    SubCategoriesModel subCategorieFilter = categorieFilter.subCategories.firstWhere((element) => element.id == item.id);
    subCategorieFilter.selected = false;
  }
}
