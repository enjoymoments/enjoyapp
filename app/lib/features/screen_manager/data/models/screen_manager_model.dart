import 'package:mozin/features/screen_manager/domain/entities/screen_manager.dart';

class ScreenManagerModel extends ScreenManager {
  
  const ScreenManagerModel();
  // const Screen_managerModel(
  //     {})
  //     : super();

  factory ScreenManagerModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return ScreenManagerModel(
      
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

  ScreenManagerModel copyWith() {
    return ScreenManagerModel();
  }
}
