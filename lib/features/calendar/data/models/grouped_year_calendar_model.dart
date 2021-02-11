import 'package:mozin/features/calendar/data/models/grouped_month_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/grouped_year_calendar.dart';

class GroupedYearCalendarModel extends GroupedYearCalendar {
  const GroupedYearCalendarModel({
    int year,
    List<GroupedMonthCalendarModel> months,
  }) : super(
          year: year,
          months: months
        );

  factory GroupedYearCalendarModel.fromJson(Map<String, dynamic> json) {
    var listMonths = <GroupedMonthCalendarModel>[];

    if (json['months'] != null) {
      json['months'].forEach((dynamic v) {
        listMonths.add(GroupedMonthCalendarModel.fromJson(v));
      });
    }

    return GroupedYearCalendarModel(
      year: json['year'],
      months: listMonths,
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

  GroupedYearCalendarModel copyWith() {
    return GroupedYearCalendarModel();
  }
}
