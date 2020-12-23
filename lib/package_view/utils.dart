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
    return DateFormat('dd/MM/yyyy -').add_Hm().format(date);
  }
}