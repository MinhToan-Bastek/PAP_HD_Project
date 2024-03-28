import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/update_info_patient.dart';

class CustomBottomNavBarApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white, // Màu nền theo hình ảnh
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_home.svg',
            height: 35,
          ),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_confirm.svg',
            height: 35,
          ),
          label: 'Xác nhận lịch tái khám',
        ),
         BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_update.svg',
            height: 35,
          ),
          label: 'Cập nhật thông tin tái khám',
        ),
         BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_flag.svg',
            height: 35,
          ),
          label: 'Báo cáo biến cố bất lợi',
        ),
        
      ],
      selectedItemColor: Colors.black, 
      unselectedItemColor: Colors.black, 
      selectedLabelStyle: TextStyle(fontSize: 8),
      unselectedLabelStyle: TextStyle(fontSize: 6),
      // Đặt index hiện tại để hỗ trợ highlighting item hiện tại, nếu cần
      currentIndex: 0, // Trang chủ được chọn mặc định
      onTap: (index) {
        switch (index) {
          case 0:
            //  Navigator.push(
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
              MaterialPageRoute(builder: (context) => UpdateInfoPatient()),
            );
            break;
          case 3:
            // Điều hướng đến trang Duyệt bệnh nhân
            break;
        }
      },
    );
  }
}
