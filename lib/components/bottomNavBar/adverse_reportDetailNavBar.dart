import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/patient_searchApproved.dart';

class BottomNavBarReportDetail extends StatelessWidget {
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
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_duyet.svg',
            height: 30,
          ),
          label: 'Duyệt',
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
            break;
          case 1:
            //  Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => PatientSearchApprovedScreen()),
            // );
            break;
           
        }
      },
    );
  }
}
