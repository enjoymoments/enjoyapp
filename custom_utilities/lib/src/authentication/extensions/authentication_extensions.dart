import 'package:firebase_auth/firebase_auth.dart';
import '../../../custom_utilities.dart';

extension user on User {
  UserAppBaseModel get toUser {
    return UserAppBaseModel(
        id: uid, email: email!, name: displayName, photo: photoURL);
  }
}
