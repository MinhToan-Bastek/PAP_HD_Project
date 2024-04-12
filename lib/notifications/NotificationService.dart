import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pap_hd/notifications/NotificationDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    saveNotifications(); 
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
      saveNotifications();
    }
  }

  //Lưu thông báo sử dụng Share Preferences
  void saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(notificationDetails.value.map((notif) => notif.toJson()).toList());
    await prefs.setString('notifications', encodedData);
  }
  void loadNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  final String? notificationsString = prefs.getString('notifications');
  if (notificationsString != null) {
    final List<dynamic> jsonData = json.decode(notificationsString);
    notificationDetails.value = jsonData.map((data) => NotificationDetail.fromJson(data)).toList();
    notificationCount.value = notificationDetails.value.length;
     print("Loaded notifications: ${notificationDetails.value.length}");
  }
}

}





