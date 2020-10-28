import 'package:mozin/modules/shared/general/models/user_app_model.dart';

abstract class UserInterface {
  Future setTokensPushNotifications(UserAppModel user, String token);
}
