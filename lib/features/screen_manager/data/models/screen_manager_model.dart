import 'package:mozin/features/screen_manager/domain/entities/screen_manager.dart';

class Screen_managerModel extends Screen_manager {
  
  const Screen_managerModel();
  // const Screen_managerModel(
  //     {})
  //     : super();

  factory Screen_managerModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return Screen_managerModel(
      
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

  Screen_managerModel copyWith() {
    return Screen_managerModel();
  }
}
