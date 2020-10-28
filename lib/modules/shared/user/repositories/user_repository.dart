import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';

class UserRepository {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  Future setTokensPushNotifications(UserAppModel user, String token) async {
    await _instance.firestore.collection('users').doc(user.id).set({
      'id': user.id,
      'name': user.name,
      'photo': user.photo,
      'email': user.email,
    }, SetOptions(merge: true));

    var _newToken = _instance.firestore
        .doc('users/' + user.id)
        .collection('tokens')
        .doc(token);

    return _newToken.set({
      'token': token,
      'createdAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem
    });
  }
}
