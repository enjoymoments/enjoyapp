import 'package:mozin/modules/shared/general/models/user_app_model.dart';

class UserWrapper {
  UserAppModel _user;

  void assignment(UserAppModel newUser) {
    _user = newUser;
  }

  UserAppModel get getUser => _user;
}
