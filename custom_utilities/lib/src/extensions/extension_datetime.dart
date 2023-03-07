import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(this.year, this.month, this.day, time.hour, time.minute);
  }

  TimeOfDay timeOfDayFromDateTime() {
    return TimeOfDay(hour: this.hour, minute: this.minute);
  }

  DateTime clearTime() {
    return DateTime(this.year, this.month, this.day, 0, 0, 0, 0, 0);
  }

  String formattedHourMinute() {
    return DateFormat().add_Hm().format(this);
  }

  DateFormat dateCustomFormat(String pattern) {
    return DateFormat(pattern);
  }

  String dateOnlyFormat() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
