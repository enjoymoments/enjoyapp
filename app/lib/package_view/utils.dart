import 'dart:math';

class StateUtils  {
  static num generateRandomNumber() {
    final Random random = Random();
    return random.nextInt(1000);
  }
}

class ExceptionsUtils {
  static Exception createException(dynamic e) {
    return e is Exception ? e : Exception(e.toString());
  }
}