import 'package:mozin/features/suggestions/domain/entities/suggestions.dart';

class SuggestionsModel extends Suggestions {
  SuggestionsModel({
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.favoriteAdded,
    String? title,
    String? description,
    String? id,
    int? like,
    int? dislike,
    bool? moreOptionsEnable,
    String? url,
    String? urlAndroid,
    String? urlIOS,
    String? urlReference,
  }) : super(
          title: title,
          description: description,
          id: id,
          like: like,
          dislike: dislike,
          moreOptionsEnable: moreOptionsEnable,
          url: url,
          urlAndroid: urlAndroid,
          urlIOS: urlIOS,
          urlReference: urlReference,
          favoriteAdded: favoriteAdded,
        );

  final String? categoryId;
  final String? categoryName;
  final String? subCategoryId;
  final String? subCategoryName;
  bool? favoriteAdded;

  factory SuggestionsModel.fromJson(
    String? categoryId,
    String? categoryName,
    String? subCategoryId,
    String? subCategoryName,
    Map<String, dynamic> json,
  ) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;

    return SuggestionsModel(
      categoryId: categoryId,
      categoryName: categoryName,
      subCategoryId: subCategoryId,
      subCategoryName: subCategoryName,
      id: json['id'],
      title: json['title'],
      description: json['description'],
      like: json['like'],
      dislike: json['dislike'],
      moreOptionsEnable: json['moreOptionsEnable'],
      favoriteAdded: json['favoriteAdded'],
      url: json['url'],
      urlAndroid: json['urlAndroid'],
      urlIOS: json['urlIOS'],
      urlReference: json['urlReference'],
    );
  }

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  SuggestionsModel copyWith() {
    return SuggestionsModel();
  }
}
