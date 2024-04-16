import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/notifications/NotificationService.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/notification.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/patient_search.dart';
import 'package:pap_hd/pages/search.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String username;
  final String pid;
  final String name;
  final String tenChuongTrinh;
  //final String maChuongTrinh;
  const CustomBottomNavBar({
    Key? key,
    required this.username,
    required this.pid,
    required this.name,
    required this.tenChuongTrinh, //required this.maChuongTrinh
  }) : super(key: key);
  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  void initState() {
    super.initState();
    // Start fetching notification count when the widget is loaded
    NotificationService().startFetchingNotificationCount(widget.username);
  }

  NotificationService notificationService = NotificationService();

  void onBellIconPressed() async {
    try {
      // Step 1: Update notification click status
      await NotificationService().changeNotificationFlagClick(widget.username);

      // Step 2: Clear and reload notifications
      NotificationService().clearNotifications();
      await NotificationService().fetchAndLoadNotifications(widget.username);

      // Step 3: Navigate to notifications page and handle back navigation
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationsPage(
                  username: widget.username,
                  pid: widget.pid,
                  name: widget.name,
                  tenChuongTrinh: widget.tenChuongTrinh,
                )),
      ).then((_) {
        // This is called when coming back to this screen from NotificationsPage
        // Step 4: Optionally reset notification count or refresh any state here
        NotificationService().notificationCount.value =
            0; // Reset count to ensure UI is updated
        // setState(() {});  // Call setState to refresh the screen if needed
        // Đặt lại số lượng thông báo sau khi quay trở lại màn hình này
        //NotificationService().notificationCount.value = NotificationService().notificationDetails.value.where((n) => !n.flagClick).length;
        setState(() {});
      });
    } catch (error) {
      // Handle errors
      print("Error handling notification icon press: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating notifications: $error')),
      );
    }
  }

  final ValueNotifier<int> notificationCount = ValueNotifier<int>(0);

  // Call this method to update notification count
  void updateNotificationCount(int newCount) {
    notificationCount.value =
        newCount; // This will automatically notify listeners
  }

  //int notificationCount = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_home.svg',
            height: 30,
          ),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: <Widget>[
              Icon(CupertinoIcons.bell, size: 30),
              Positioned(
                right: 0,
                child: ValueListenableBuilder<int>(
                  valueListenable:
                      NotificationService.instance.notificationCount,
                  builder: (_, count, __) {
                    print(
                        "Số lượng thông báo hiện tại: $count"); // Thêm để debug
                    return count > 0
                        ? Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container(); // Trường hợp không có thông báo
                  },
                ),
              ),
            ],
          ),
          label: 'Thông báo hệ thống',
        ),
        // BottomNavigationBarItem(
        //   icon: SvgPicture.asset(
        //     'assets/bottomNavBar/icon_home.svg',
        //     height: 30,
        //   ),
        //   label: 'Trang chủ',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(CupertinoIcons.bell, size: 30),
        //   // icon: SvgPicture.asset(
        //   //   'assets/bottomNavBar/icon_chat.svg',
        //   //   height: 30,
        //   // ),
        //   label: 'Thông báo hệ thống',
        // ),

        // BottomNavigationBarItem(
        //   icon: SvgPicture.asset(
        //     'assets/bottomNavBar/icon_scan.svg',
        //     height: 30,
        //   ),
        //   label: 'Scan tài liệu',
        // ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search, size: 30),
          // icon: SvgPicture.asset(
          //   'assets/bottomNavBar/icon_verify.svg',
          //   height: 35,
          // ),
          label: 'Tìm bệnh nhân',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_regis.svg',
            height: 30,
          ),
          label: 'Đăng ký bệnh nhân',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(fontSize: 8),
      unselectedLabelStyle: TextStyle(fontSize: 8),
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        username: widget.username,
                        name: widget.name,
                        tenChuongTrinh: widget.tenChuongTrinh,
                      )),
            );
            break;
          case 1:
            onBellIconPressed();
            // NotificationService().clearNotifications();
            // NotificationService().fetchAndLoadNotifications(widget.username).then((_) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => NotificationsPage(
            //       username: widget.username,
            //       pid: widget.pid,
            //       name: widget.name,
            //       tenChuongTrinh: widget.tenChuongTrinh,
            //     )),
            //   );
            // }).catchError((error) {
            //   // Handle any errors here
            //   print("Error fetching notifications: $error");
            // });
            break;

          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(
                        username: widget.username,
                        pid: widget.pid,
                        name: widget.name,
                        tenChuongTrinh: widget.tenChuongTrinh,
                      )),
            );
            break;
          case 3:
            // Điều hướng đến trang Đăng ký bệnh nhân
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PatientRegistScreen(
                        maChuongTrinh: '',
                        username: widget.username,
                        pid: widget.pid,
                        name: widget.name,
                        tenChuongTrinh: widget.tenChuongTrinh,
                      )),
            );
            break;
        }
      },
    );
  }
}
