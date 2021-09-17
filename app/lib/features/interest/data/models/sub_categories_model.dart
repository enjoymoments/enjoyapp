import 'package:mozin/features/interest/domain/entities/sub_categories.dart';

class SubCategoriesModel extends SubCategories {
  SubCategoriesModel({
    this.selected,
    String? id,
    String? name,
  }) : super(
          id: id,
          name: name,
        );

  bool? selected;

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      id: json['id'],
      name: json['name'],
      selected: json['selected'],
    );
  }

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'selected': selected,
    };
    return data;
  }

  SubCategoriesModel copyWith({
    String? id,
    String? name,
  }) {
    return SubCategoriesModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
