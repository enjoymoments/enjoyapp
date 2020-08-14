import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozin/modules/shared/models/user.dart';

extension user on FirebaseUser {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoUrl);
  }
}