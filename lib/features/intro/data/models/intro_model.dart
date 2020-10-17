import 'package:mozin/features/intro/domain/entities/intro.dart';

class IntroModel extends Intro {
  
  const IntroModel();
  // const IntroModel(
  //     {})
  //     : super();

  factory IntroModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return IntroModel(
      
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

  IntroModel copyWith() {
    return IntroModel();
  }
}
