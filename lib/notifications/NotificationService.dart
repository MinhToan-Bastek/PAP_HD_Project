// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:pap_hd/notifications/NotificationDetail.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   final ValueNotifier<int> notificationCount = ValueNotifier<int>(0);
//   final ValueNotifier<List<NotificationDetail>> notificationDetails = ValueNotifier<List<NotificationDetail>>([]);

//   void addNotification(String title, String body) {
//     final notification = NotificationDetail(
//       title: title,
//       body: body,
//       receivedTime: DateTime.now(),
//     );
//     notificationDetails.value = [notification, ...notificationDetails.value];
//     notificationCount.value = notificationDetails.value.length;
//     saveNotifications();
//   }

//   void clearNotifications() {
//     notificationCount.value = 0;
//   }
//    void removeNotificationAt(int index) {
//     final currentList = notificationDetails.value;
//     if (index >= 0 && index < currentList.length) {
//       currentList.removeAt(index);
//       notificationDetails.value = [...currentList]; // Cập nhật danh sách thông báo
//       notificationCount.value = currentList.length; // Cập nhật số lượng thông báo
//       saveNotifications();
//     }
//   }

//   //Lưu thông báo sử dụng Share Preferences
//   void saveNotifications() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String encodedData = json.encode(notificationDetails.value.map((notif) => notif.toJson()).toList());
//     await prefs.setString('notifications', encodedData);
//   }
//   void loadNotifications() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? notificationsString = prefs.getString('notifications');
//     if (notificationsString != null) {
//       final List<dynamic> jsonData = json.decode(notificationsString);
//       notificationDetails.value = jsonData.map((data) => NotificationDetail.fromJson(data)).toList();
//       notificationCount.value = notificationDetails.value.length;
//     } else {
//       // Có thể tải từ API ngoài
//       await fetchNotificationsFromApi();
//     }
//   }

//   Future<void> fetchNotificationsFromApi() async {
//     var url = Uri.parse('http://119.82.141.248:2345/api/Values/GetListNotification');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       List<dynamic> list = json.decode(response.body);
//       notificationDetails.value = list.map((data) => NotificationDetail.fromJson(data)).toList();
//       notificationCount.value = notificationDetails.value.length;
//       saveNotifications();
//     } else {
//       throw Exception('Không tải được thông báo');
//     }
//   }

// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'NotificationDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  factory NotificationService() => instance;
  NotificationService._internal();

  final ValueNotifier<List<NotificationDetail>> notificationDetails = ValueNotifier<List<NotificationDetail>>([]);
  final ValueNotifier<int> notificationCount = ValueNotifier<int>(0);
  
  void incrementNotificationCount() {
    notificationCount.value++;
  }

  Future<void> fetchAndLoadNotifications(String username) async {
    var url = Uri.parse('http://119.82.141.248:2345/api/Values/GetListNotification');
    var response = await http.post(url, 
        body: json.encode({"username": username}), 
        headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<NotificationDetail> notifications = jsonData.map((data) => NotificationDetail.fromJson(data)).toList();
      // Sort notifications by receivedTime from newest to oldest
      notifications.sort((a, b) => b.receivedTime.compareTo(a.receivedTime));
      notificationDetails.value = notifications;

      notificationCount.value = jsonData.length; 
       notificationCount.value = notifications.where((n) => !n.flagClick).length;
       
      //notificationCount.value = notifications.length;  // Update count based on the list's current length
    } else {
      throw Exception('Failed to load notifications: ${response.body}');
    }
  }
//  Future<void> fetchAndLoadNotifications(String username) async {
//     var url = Uri.parse('https://yourapi.com/GetListNotification');
//     var response = await http.post(url, body: json.encode({"username": username}), headers: {"Content-Type": "application/json"});
//     if (response.statusCode == 200) {
//       List<dynamic> list = json.decode(response.body);
//       notificationDetails.value = list.map((data) => NotificationDetail.fromJson(data)).toList();
//       notificationCount.value = notificationDetails.value.length;
//     } else {
//       throw Exception('Failed to load notifications: ${response.body}');
//     }
//   }

   Future<void> changeNotificationFlagClick(String username) async {
    var url = Uri.parse('http://119.82.141.248:2345/api/Values/ChangeNotificationFlagClick');
    var response = await http.post(url, body: json.encode({"username": username}), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      print("FlagClick updated successfully: ${response.body}");
      fetchAndLoadNotifications(username);  // Reload notifications to update flagClick state
    } else {
      throw Exception('Failed to change notification flag: ${response.body}');
    }
  }

// Future<void> changeNotificationFlagRead(String username,int id) async {
//     var url = Uri.parse('http://119.82.141.248:2345/api/Values/ChangeNotificationFlagRead');
//     var response = await http.post(url, body: json.encode({"username": username}), headers: {"Content-Type": "application/json"});
//     if (response.statusCode == 201) {
//       print("FlagRead updated successfully: ${response.body}");
//       fetchAndLoadNotifications(username);  
//     } else {
//       throw Exception('Failed to change notification flag: ${response.body}');
//     }
// }

// Future<bool> changeNotificationFlagRead(String username, int id) async {
//     var url = Uri.parse('http://119.82.141.248:2345/api/Values/ChangeNotificationFlagRead');
//     var response = await http.post(url, body: json.encode({'username': username, 'id': id}));

//    if (response.statusCode == 201) {
     
//       return true;
//     } else {
      
//       print("Error updating notification flag: ${response.body}");
//       return false;
//     }
//   }

 Future<void> changeNotificationFlagRead(String username, int id) async {
        var url = Uri.parse('http://119.82.141.248:2345/api/Values/ChangeNotificationFlagRead');
        var response = await http.post(url, 
            headers: {"Content-Type": "application/json"},
            body: json.encode({"username": username, "Id": id})  // Ensure correct JSON key for notificationId
        );

        if (response.statusCode == 201) {  
            print("Notification read flag updated successfully: ${response.body}");
            fetchAndLoadNotifications(username);  
        } else {
            
            print("Failed to change notification read flag: ${response.body}");
            throw Exception('Failed to change notification read flag: ${response.body}');
        }
    }


Future<void> fetchNotificationCount(String username) async {
    var url = Uri.parse('http://119.82.141.248:2345/api/Values/GetNotificationNumberBeforeClick');
    var response = await http.post(url, body: json.encode({"username": username}), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      notificationCount.value = data['FlagClick'];
    } else {
      throw Exception('Failed to load notification count');
    }
  }
  void startFetchingNotificationCount(String username) {
    Timer.periodic(Duration(minutes: 1), (timer) {
      fetchNotificationCount(username).catchError((err) {
        print('Error fetching notifications: $err');
      });
    });
  }
  
void clearNotifications() {
  for (var notification in notificationDetails.value) {
    notification.flagClick = true;  // Đánh dấu là đã click
  }
  notificationCount.value = 0;  // Đặt lại số lượng thông báo
}

  void removeNotificationAt(int index) {
    if (index >= 0 && index < notificationDetails.value.length) {
      notificationDetails.value.removeAt(index);
      notificationCount.value = notificationDetails.value.length;
    }
  }

   // Ví dụ về việc lưu số lượng thông báo
void saveNotificationCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int currentCount = NotificationService().notificationCount.value;  // Giả sử bạn tính toán và cập nhật số này ở đâu đó trong app
  await prefs.setInt('notification_count', currentCount);
}
void loadNotificationCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedCount = prefs.getInt('notification_count') ?? 0;
  NotificationService().notificationCount.value = savedCount;
}


}

