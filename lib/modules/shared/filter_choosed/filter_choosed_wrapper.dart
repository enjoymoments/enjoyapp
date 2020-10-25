import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';

class FilterChoosedWrapper {
  FilterChoosedModel _filterChoosed;

  FilterChoosedModel get getFilterChoosed => _filterChoosed;

  void assignment(FilterChoosedModel newFilterChoosed) {
    _filterChoosed = newFilterChoosed;
  }

  void changePrice(double minPrice, double maxPrice) {
    _filterChoosed.changePrice(minPrice, maxPrice);
  }

  void changeDistance(double minDistance, double maxDistance) {
    _filterChoosed.changeDistance(minDistance, maxDistance);
  }

  void changeTime(double minTime, double maxTime) {
    _filterChoosed.changeTime(minTime, maxTime);
  }

  void insertCategorie(CategoriesModel item) {
    item.selected = true;
    _filterChoosed.insertCategorie(item);
  }

  void removeCategorie(CategoriesModel item) {
    _filterChoosed.removeCategorie(item);
  }

  void insertSubCategorie(CategoriesModel categorie, SubCategoriesModel item) { 
    _filterChoosed.insertSubCategorie(categorie, item);
  }

  void removeSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    _filterChoosed.removeSubCategorie(categorie, item);
  }
}
