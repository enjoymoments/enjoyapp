import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<String> configureAsync() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

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
