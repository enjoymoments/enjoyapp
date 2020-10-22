import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';

class FilterChoosedWrapper {
  FilterChoosedModel _filterChoosed;

  FilterChoosedModel get getFilterChoosed => _filterChoosed;

  void assignment(FilterChoosedModel newFilterChoosed) {
    _filterChoosed = newFilterChoosed;
  }

  void insertCategorie(CategoriesModel item) {
    _filterChoosed.insertCategorie(item);
  }

  void removeCategorie(CategoriesModel item) {
    _filterChoosed.removeCategorie(item);
  }
}
