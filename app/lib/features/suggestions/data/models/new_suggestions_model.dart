
class NewSuggestionsModel {
  NewSuggestionsModel({
    required this.title,
    this.description,
    this.url,
    required this.categoryId,
    required this.subCategoryId,
    
    //TODO:only 1 subCategory select for now
    //required this.categoriesSelected,
  });

  final String title;
  final String? description;
  final String? url;
  
  //TODO:only 1 subCategory select for now
  //final Map<String, List<String>> categoriesSelected;

  final String categoryId;
  final String subCategoryId;

  @override
  String toString() {
    return '''
    ''';
  }
}
