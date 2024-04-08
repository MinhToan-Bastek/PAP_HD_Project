import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/patient_search.dart';
import 'package:pap_hd/pages/search.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String username;
  final String pid;
  final String name;
  final String tenChuongTrinh;
  const CustomBottomNavBar(
      {super.key,
      required this.username,
      required this.pid,
      required this.name,
      required this.tenChuongTrinh});
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white, // Màu nền theo hình ảnh
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
          icon: Icon(CupertinoIcons.bell, size: 30),
          // icon: SvgPicture.asset(
          //   'assets/bottomNavBar/icon_chat.svg',
          //   height: 30,
          // ),
          label: 'Thông báo hệ thống',
        ),
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
      // Đặt index hiện tại để hỗ trợ highlighting item hiện tại, nếu cần
      currentIndex: 0, // Trang chủ được chọn mặc định
      onTap: (index) {
        switch (index) {
          case 0:
            //  Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
            break;
          case 1:
            // Điều hướng đến trang thông báo hệ thống
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
