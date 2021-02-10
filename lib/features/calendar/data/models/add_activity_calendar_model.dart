import 'package:mozin/features/calendar/domain/entities/add_activity_calendar.dart';

class AddActivityCalendarModel extends AddActivityCalendar {
  const AddActivityCalendarModel({
    String sessionId,
    String activityId,
  }) : super(
          sessionId: sessionId,
          activityId: activityId,
        );

  factory AddActivityCalendarModel.fromJson(Map<String, dynamic> json) {
    return AddActivityCalendarModel(
      sessionId: json['sessionId'],
      activityId: json['activityId'],
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

  AddActivityCalendarModel copyWith() {
    return AddActivityCalendarModel();
  }
}
