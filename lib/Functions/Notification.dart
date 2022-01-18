import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager();

  late FirebaseMessaging messaging;

  Future<void> init() async {
    // For iOS request permission first.
    messaging.requestPermission();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });
  }
}
