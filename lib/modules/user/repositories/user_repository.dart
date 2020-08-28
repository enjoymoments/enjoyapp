import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozin/modules/firebase/firebase_instance_provider.dart';

class UserRepository {
  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  Future setTokensPushNotifications(String userId, String token) {
    return _instance.firestore.doc('users/' + userId).get().then((onValue) {
      var tokens = onValue.reference.collection('tokens').doc(token);

      tokens.set({
        'token': token,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    });
  }
}
