import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/user/datasources/user_remote_data_source.dart';
import 'package:mozin/modules/shared/user/models/user_info_model.dart';

class UserRepository {
  UserRepository({
    required this.remoteDataSource,
  });

  final UserRemoteDataSource? remoteDataSource;

  final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();

  ///TODO:review this CHANGE THIS FOR BACKEND
  Future<bool> createUserInFirestore(UserAppModel user) async {
    QuerySnapshot<Map<String, dynamic>> _result = await _instance.firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();
        
    if (_result.docs.length == 0) {
      await _instance.firestore.collection('users').doc(user.id).set({
        'id': user.id,
        'name': user.name,
        'photo': user.photo,
        'email': user.email,
      }, SetOptions(merge: true));

      return Future.value(true);
    }

    return Future.value(false);
  }

  ///TODO:review this CHANGE THIS FOR BACKEND
  Future setTokensPushNotifications(UserAppModel user, String? token) async {
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

  Future<Either<UserInfoModel, Exception>> setUserInfo() async {
    try {
      var response = await remoteDataSource!.setUserInfo();
      return Left<UserInfoModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<UserInfoModel, Exception>(e);
    }
  }
}
