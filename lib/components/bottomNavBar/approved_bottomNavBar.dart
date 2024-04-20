import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/adverse_reporting.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/info_ReExam_Pending.dart';
import 'package:pap_hd/pages/list_ReExam.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/update_info_patient.dart';

class CustomBottomNavBarApproved extends StatelessWidget {
  final String tenChuongTrinh;
  final Map<String, dynamic> patientDetail;
  final String username;
  const CustomBottomNavBarApproved({super.key, required this.tenChuongTrinh, required this.patientDetail, required this.username});
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
            'assets/bottomNavBar/icon_confirm.svg',
            height: 30,
          ),
          label: 'Xác nhận lịch tái khám',
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play_outlined, size: 30),
          label: 'Danh sách phiếu tái khám',
        ),
         BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_update.svg',
            height: 30,
          ),
          label: 'Cập nhật thông tin tái khám',
        ),
         BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_flag.svg',
            height: 30,
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => InfoReExamPending()),
            // );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListReExam(username: username,patientDetail: patientDetail,tenChuongTrinh: tenChuongTrinh)),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateInfoPatient(tenChuongTrinh: tenChuongTrinh,patientDetail: patientDetail,username: username,)),
            );
            break;
             case 4:
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdverseReporting(tenChuongTrinh: tenChuongTrinh, patientDetail: patientDetail,username: username,)),
            );
            break;
        }
      },
    );
  }
}
