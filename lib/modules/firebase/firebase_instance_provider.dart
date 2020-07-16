import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstanceProvider {
  final Firestore firestore = Firestore.instance;

  static FirestoreInstanceProvider _instance;

  factory FirestoreInstanceProvider() {
    _instance ??= FirestoreInstanceProvider._internalConstructor();

    return _instance;
  }

  FirestoreInstanceProvider._internalConstructor();
}