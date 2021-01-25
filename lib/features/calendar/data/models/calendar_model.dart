import 'package:mozin/features/calendar/domain/entities/calendar.dart';

class CalendarModel extends Calendar {
  
  const CalendarModel();
  // const CalendarModel(
  //     {})
  //     : super();

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = <String, dynamic>{};
    data = json;
    
    return CalendarModel(
      
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

  CalendarModel copyWith() {
    return CalendarModel();
  }
}
