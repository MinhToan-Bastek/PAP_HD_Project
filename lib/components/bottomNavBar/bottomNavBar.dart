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
  const CustomBottomNavBar(
      {Key? key,
      required this.username,
      required this.pid,
      required this.name,
      required this.tenChuongTrinh}): super(key: key);
  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  void updateNotificationCount(int count) {
    setState(() {
      notificationCount += count;
    });
  }
  int notificationCount = 0;
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
                  valueListenable: NotificationService().notificationCount,
                  builder: (_, count, __) => count > 0
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
                      : Container(), // Không hiển thị gì nếu không có thông báo
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
            //  Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
            break;
          case 1:
          NotificationService().clearNotifications(); 
             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsPage()),
    );
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
