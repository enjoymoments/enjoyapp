import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
import 'package:mozin/modules/shared/general/models/key_value.dart';
import 'package:mozin/modules/shared/general/services/local_storage_service.dart';

class FilterChoosedWrapper {
  FilterChoosedWrapper({required this.localStorageService});

  static String keyFilter = 'key_filter';

  FilterChoosedModel? _filterChoosed;
  final LocalStorageService? localStorageService;

  FilterChoosedModel? get getFilterChoosed => _filterChoosed;

  void init() {
    if (localStorageService!.containsKey(keyFilter)) {
      readLocal();
      return;
    }

    this.assignment(FilterChoosedModel.initial());
  }

  void assignment(FilterChoosedModel newFilterChoosed) {
    _filterChoosed = newFilterChoosed;
  }

  void changePrice(double minPrice, double maxPrice) {
    _filterChoosed!.changePrice(minPrice, maxPrice);
  }

  void changeDistance(double minDistance, double maxDistance) {
    _filterChoosed!.changeDistance(minDistance, maxDistance);
  }

  void changeTime(double minTime, double maxTime) {
    _filterChoosed!.changeTime(minTime, maxTime);
  }

  void insertCategorie(CategoriesModel item) {
    item.selected = true;
    _filterChoosed!.insertCategorie(item);
    saveLocal();
  }

  void removeCategorie(CategoriesModel item) {
    item.selected = false;
    _filterChoosed!.removeCategorie(item);
    saveLocal();
  }

  void insertSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    _filterChoosed!.insertSubCategorie(categorie, item);
    saveLocal();
  }

  void removeSubCategorie(CategoriesModel categorie, SubCategoriesModel item) {
    _filterChoosed!.removeSubCategorie(categorie, item);
    saveLocal();
  }

  void saveLocal() {
    List<dynamic> _categories = <dynamic>[];
    List<CategoriesModel> _categoriesCopy =
        List<CategoriesModel>.from(_filterChoosed!.categories!);

    for (CategoriesModel categorie in _categoriesCopy) {
      _categories.add(categorie.toJson());
    }

    var _result = json.encode(_filterChoosed!.toJson(_categories));

    localStorageService!
        .put(KeyValue<String, String>(key: keyFilter, value: _result))
        .catchError((onError) {
      print('save local error');
    });
  }

  void readLocal() {
    localStorageService!.get(keyFilter).then((value) {
      var _decode = json.decode(value);

      var _result = FilterChoosedModel.fromJson(_decode);

      this.assignment(_result);
    }).catchError((onError) {
      print('read local error');
    });
  }
}
