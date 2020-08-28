import 'dart:math';

class StateUtils  {
  static num generateRandomNumber() {
    final Random random = Random();
    return random.nextInt(1000);
  }
}