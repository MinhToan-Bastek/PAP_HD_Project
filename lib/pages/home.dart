
// import 'package:flutter/material.dart';
// import 'package:pap_hd/components/homeScreen/body.dart';
// import 'package:pap_hd/components/homeScreen/header_home.dart';
// import 'package:pap_hd/components/homeScreen/title_body.dart';
// import 'package:pap_hd/components/homeScreen/weather_home.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/homeScreen/home_background.png'),
//               fit: BoxFit.cover, 
//             ),
//           ),
//           child: Column(
//             children: [
//                SizedBox(height: 15),
//               Header(),
//               // Các phần khác của màn hình
//               WeatherWidget(),
//                SizedBox(height: 15),
//               TitleBody(),
//               //ProjectsGrid(),
      
             
//             ],
//           ),
//         ),
//       ),
//       // Add a BottomNavigationBar if needed
//     );
//   }
// }


import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pap_hd/api/firebase_api.dart';
import 'package:pap_hd/components/homeScreen/body.dart';
import 'package:pap_hd/components/homeScreen/header_home.dart';
import 'package:pap_hd/components/homeScreen/title_body.dart';
import 'package:pap_hd/components/homeScreen/weather_home.dart';
import 'package:pap_hd/notifications/NotificationService.dart';
import 'package:pap_hd/notifications/flushBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
   final String username;
   final String name;
   final String tenChuongTrinh;
  const HomeScreen({super.key, required this.username, required this.name, required this.tenChuongTrinh});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _seeAll = false;
  final NotificationService notificationService = NotificationService();  
  //Test thông báo
   @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print("Got a message whilst in the foreground!");
  print("Message data: ${message.data}");

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }

  // Handling notification
  String title = message.notification?.title ?? "No Title";
  String body = message.notification?.body ?? "No Body";
  String id = message.data['id'].toString();

  // Displaying the notification
  showNotificationFlushbar(context, title, body, id);
});
   
    loadNotifications();
        // FirebaseApi().initNotifications(context);
        // loadNotificationCount();
  }
  void loadNotifications() async {
    try {
      await notificationService.fetchNotificationCount(widget.username);
      print("Notifications loaded successfully");
    } catch (e) {
      print("Failed to load notifications: $e");
    }
  }
 

 



  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height, // Đặt chiều cao bằng với chiều cao màn hình
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/homeScreen/home_background.png'),
              fit: BoxFit.cover, 
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              Header(name: widget.name),
              // Các phần khác của màn hình
              WeatherWidget(),
              SizedBox(height: 15),
              TitleBody(
                seeAllPressed: () {
                  setState(() {
                    _seeAll = !_seeAll;
                  });
                },
                isSeeAll: _seeAll,
              ),
               Flexible( // Cho phép GridView mở rộng đầy đủ không gian có thể
              child: ProjectsGrid(seeAll: _seeAll, username: widget.username, name: widget.name,TenChuongTrinh: widget.tenChuongTrinh,),
            ),
              //ProjectsGrid(seeAll: _seeAll),
              
            ],
          ),
        ),
      ),
      // Add a BottomNavigationBar if needed
    );
  }
}
