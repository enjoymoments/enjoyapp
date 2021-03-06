import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';

extension user on User {
  UserAppModel get toUser {
    return UserAppModel(id: uid, email: email!, name: displayName, photo: photoURL);
  }
}