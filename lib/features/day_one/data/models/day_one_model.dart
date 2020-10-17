import 'package:mozin/features/day_one/domain/entities/day_one.dart';

class DayOneModel extends DayOne {
  
  const DayOneModel();
  // const Day_oneModel(
  //     {})
  //     : super();

  factory DayOneModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return DayOneModel(
      
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

  DayOneModel copyWith() {
    return DayOneModel();
  }
}
