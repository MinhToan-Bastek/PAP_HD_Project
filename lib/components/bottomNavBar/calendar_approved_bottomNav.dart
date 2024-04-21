import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/body_Calendar_ReExam.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/info_ReExam_Pending.dart';
import 'package:pap_hd/model/img_provider.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CalendarBottomNavBarApproved extends StatelessWidget {
   final GlobalKey<CalendarReExamBodyState> formKey;
   final VoidCallback onSavePressed;
  CalendarBottomNavBarApproved({super.key, required this.formKey, required this.onSavePressed});


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
        // BottomNavigationBarItem(
        //   icon: SvgPicture.asset(
        //     'assets/bottomNavBar/icon_scan.svg',
        //     height: 30,
        //   ),
        //   label: 'Chụp tài liệu',
        // ),
        // BottomNavigationBarItem(
        //   icon: SvgPicture.asset(
        //     'assets/bottomNavBar/icon_image.svg',
        //     height: 30,
        //   ),
        //   label: 'Chọn từ thư viện',
        // ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_save.svg',
            height: 30,
          ),
          label: 'Lưu',
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
            //  Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
            break;
        
          case 1:
            onSavePressed();
            break;
        }
      },
    );
  }
}
