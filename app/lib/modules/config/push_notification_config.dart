import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> configureAsync() async {
    //TODO:review this
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );

    //TODO:in development
    //_firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);

    var token = await _firebaseMessaging.getToken();

    return token;
  }

  Future<void> subscribeToTopic(String topic) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeToTopic(String topic) {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
