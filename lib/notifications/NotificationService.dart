import 'package:flutter/material.dart';
import 'package:pap_hd/notifications/NotificationDetail.dart';

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();

//   factory NotificationService() => _instance;

//   NotificationService._internal();

//   final ValueNotifier<int> notificationCount = ValueNotifier<int>(0);

//   void incrementNotification() {
//     notificationCount.value += 1;
//   }

//   void clearNotifications() {
//     notificationCount.value = 0;
//   }
// }

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final ValueNotifier<int> notificationCount = ValueNotifier<int>(0);
  final ValueNotifier<List<NotificationDetail>> notificationDetails = ValueNotifier<List<NotificationDetail>>([]);

  void addNotification(String title, String body) {
    final notification = NotificationDetail(
      title: title,
      body: body,
      receivedTime: DateTime.now(),
    );
    notificationDetails.value = [notification, ...notificationDetails.value];
    notificationCount.value = notificationDetails.value.length;
  }

  void clearNotifications() {
    notificationCount.value = 0;
  }
   void removeNotificationAt(int index) {
    final currentList = notificationDetails.value;
    if (index >= 0 && index < currentList.length) {
      currentList.removeAt(index);
      notificationDetails.value = [...currentList]; // Cập nhật danh sách thông báo
      notificationCount.value = currentList.length; // Cập nhật số lượng thông báo
    }
  }
}





