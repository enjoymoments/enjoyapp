import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/user/interfaces/user_interface.dart';
import 'package:mozin/modules/shared/user/repositories/user_repository.dart';

class UserService implements UserInterface {

  final UserRepository userRepository;

  UserService(this.userRepository);

  @override
  Future setTokensPushNotifications(UserAppModel user, String token) {
    return this.userRepository.setTokensPushNotifications(user, token);
  }
}