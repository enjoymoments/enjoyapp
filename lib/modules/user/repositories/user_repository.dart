import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozin/modules/firebase/firebase_instance_provider.dart';

class UserRepository {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  Future setTokensPushNotifications(
      String userId, String userEmail, String token) async {
    await _instance.firestore.collection('users').doc(userId).set({
      'email': userEmail,
    });

    var _newToken = _instance.firestore
        .doc('users/' + userId)
        .collection('tokens')
        .doc(token);

    return _newToken.set({
      'token': token,
      'createdAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem
    });
  }
}
