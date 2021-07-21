import 'package:mozin/features/suggestions/domain/entities/suggestions.dart';

class SuggestionsModel extends Suggestions {
  
  const SuggestionsModel();
  // const SuggestionsModel(
  //     {})
  //     : super();

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return SuggestionsModel(
      
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
