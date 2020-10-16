import 'package:mozin/features/time_line/domain/entities/time_line.dart';

class Time_lineModel extends Time_line {
  
  const Time_lineModel();
  // const Time_lineModel(
  //     {})
  //     : super();

  factory Time_lineModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return Time_lineModel(
      
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

  Time_lineModel copyWith() {
    return Time_lineModel();
  }
}
