import 'package:mozin/features/more/domain/entities/more.dart';

class MoreModel extends More {
  
  const MoreModel();
  // const MoreModel(
  //     {})
  //     : super();

  factory MoreModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return MoreModel(
      
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

  MoreModel copyWith() {
    return MoreModel();
  }
}
