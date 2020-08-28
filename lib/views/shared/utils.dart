import 'dart:math';

import 'package:intl/intl.dart';

class StateUtils  {
  static num generateRandomNumber() {
    final Random random = Random();
    return random.nextInt(1000);
  }
}

class DateUtils {
  static String dateFormat(DateTime date) {
    //TODO:review
    return DateFormat('dd/MM/yyyy').format(date);
  }
}