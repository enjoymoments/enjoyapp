import 'package:mozin/modules/user/interfaces/user_interface.dart';
import 'package:mozin/modules/user/repositories/user_repository.dart';

class UserService implements UserIterface {

  final UserRepository userRepository;

  UserService(this.userRepository);

  @override
  Future setTokensPushNotifications(String userId, String userEmail, String token) {
    return this.userRepository.setTokensPushNotifications(userId, userEmail, token);
  }
}