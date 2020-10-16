import 'package:mozin/features/interest/domain/entities/interest.dart';

class InterestModel extends Interest {
  
  const InterestModel();
  // const InterestModel(
  //     {})
  //     : super();

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return InterestModel(
      
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

  InterestModel copyWith() {
    return InterestModel();
  }
}
