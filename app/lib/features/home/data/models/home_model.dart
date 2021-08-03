import 'package:mozin/features/home/domain/entities/home.dart';

class HomeModel extends Home {
  
  const HomeModel();
  // const HomeModel(
  //     {})
  //     : super();

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return HomeModel(
      
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

  HomeModel copyWith() {
    return HomeModel();
  }
}
