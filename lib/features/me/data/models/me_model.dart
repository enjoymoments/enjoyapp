import 'package:mozin/features/me/domain/entities/me.dart';

class MeModel extends Me {
  
  const MeModel();
  // const MeModel(
  //     {})
  //     : super();

  factory MeModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return MeModel(
      
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

  MeModel copyWith() {
    return MeModel();
  }
}
