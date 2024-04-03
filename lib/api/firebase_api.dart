
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('TokenFCM: $fCMToken');
//   }
// }

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initNotifications(void Function(String, String) onMessage) async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    print('TokenFCM: $fCMToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final String? title = message.notification?.title;
      final String? body = message.notification?.body;
      if (title != null && body != null) {
        onMessage(title, body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.body}");
    });
  }
}

