import 'package:mozin/features/suggestions/domain/entities/suggestions.dart';

class SuggestionsModel extends Suggestions {
  const SuggestionsModel({
    String title,
    String description,
    String id,
    int like,
    int dislike,
    bool moreOptionsEnable,
  }) : super(
          title: title,
          description: description,
          id: id,
          like: like,
          dislike: dislike,
          moreOptionsEnable: moreOptionsEnable,
        );

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;

    return SuggestionsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      like: json['like'],
      dislike: json['dislike'],
      moreOptionsEnable: json['moreOptionsEnable'],
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
