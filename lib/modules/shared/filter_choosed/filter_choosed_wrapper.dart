import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';

class FilterChoosedWrapper {
  FilterChoosedModel _filterChoosed;

  FilterChoosedWrapper({
    FilterChoosedModel filterChoosed,
  }) {
    _filterChoosed = filterChoosed ?? FilterChoosedModel.initial();
  }

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
