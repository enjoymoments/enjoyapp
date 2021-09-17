import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/features/interest/domain/entities/categories.dart';

class CategoriesModel extends Categories {
  CategoriesModel({
    this.selected,
    String? id,
    String? name,
    List<SubCategoriesModel>? subCategories,
  }) : super(
          id: id,
          name: name,
          subCategories: subCategories,
        );

  bool? selected;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    var listSubCategories = <SubCategoriesModel>[];

    if (json['subCategories'] != null) {
      json['subCategories'].forEach((dynamic v) {
        listSubCategories.add(SubCategoriesModel.fromJson(v));
      });
    }

    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      selected: json['selected'],
      subCategories: listSubCategories,
    );
  }

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    var listSubCategories = [];
    subCategories!.forEach((dynamic v) {
      listSubCategories.add(v.toJson());
    });

    data['id'] = this.id;
    data['name'] = this.name;
    data['selected'] = selected;
    data['subCategories'] = listSubCategories;

    return data;
  }

  CategoriesModel copyWith({
    String? id,
    String? name,
    List<SubCategoriesModel>? subCategories,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subCategories: subCategories ?? this.subCategories as List<SubCategoriesModel>?,
    );
  }
}
