
import 'dart:convert';

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



// class FirebaseApi {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   void initNotifications(void Function(String, String, String) onMessage) async {
//     await _firebaseMessaging.requestPermission();

//     final fCMToken = await _firebaseMessaging.getToken();
//     print('TokenFCM: $fCMToken');

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final String? title = message.notification?.title;
//       final String? body = message.notification?.body;
//        String id = message.data['id'] ?? 'No ID';
//       if (title != null && body != null) {
//         onMessage(title, body,id);
//       }
//     });

//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //   print("onMessageOpenedApp: ${message.notification?.body}");
//     // });
//     // Handle notifications when the app is opened from a terminated state
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       final String? title = message.notification?.title;
//       final String? body = message.notification?.body;
//       String id = message.data['id'] ?? 'No ID';  // Default ID if none provided
//       print("Notification Clicked! Title: $title, Body: $body, ID: $id");
//     });
//   }
// }


// class FirebaseApi {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   void initNotifications(void Function(String, String, String) onMessage) async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('FCM Token: $fCMToken');

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final String? title = message.notification?.title;
//       final String? body = message.notification?.body;
      
     
//       String id = "No ID";  
//       if (message.data.isNotEmpty) {
//         id = message.data['id'];  
//       }

//       if (title != null && body != null) {
//         onMessage(title, body, id);  
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("onMessageOpenedApp: ${message.notification?.body}");
//     });
//   }
// }




import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pap_hd/notifications/flushBar.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

   void initNotifications(BuildContext context) async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final String? title = message.notification?.title;
      final String? body = message.notification?.body;
      String id = message.data['id'].toString(); // Get the ID from data payload
       String data2 = message.data.toString();
      
      _showNotification(context, title ?? "No title", body ?? "No body", id,data2);
      print('ID là : $id');
      print('data là : $data2');
    });
  }
 
    void _showNotification(
      BuildContext context, String title, String body, String id, String data2) {
    var androidDetails = AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      importance: Importance.high,
    );
   
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(0, title, body, generalNotificationDetails);

    // Use Flushbar to show the notification
    showNotificationFlushbar(context, title, body, id,data2);
  }
}


