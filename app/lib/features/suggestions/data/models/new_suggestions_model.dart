
class NewSuggestionsModel {
  NewSuggestionsModel({
    required this.title,
    this.description,
    this.url,
    required this.categoriesSelected,
  });

  final String title;
  final String? description;
  final String? url;
  final Map<String, List<String>> categoriesSelected;

  @override
  String toString() {
    return '''
    ''';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
