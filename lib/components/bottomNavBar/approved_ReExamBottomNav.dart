import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/model/examPending.dart';
import 'package:pap_hd/pages/approved_calendarReExam.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/patient_searchApproved.dart';
import 'package:provider/provider.dart';

class BottomNavBarReExam extends StatefulWidget {
  final String tenChuongTrinh;
  

  const BottomNavBarReExam({super.key, required this.tenChuongTrinh, });
  @override
  State<BottomNavBarReExam> createState() => _BottomNavBarReExamState();
}

class _BottomNavBarReExamState extends State<BottomNavBarReExam> {
  @override
  Widget build(BuildContext context) {
    
     final examInfo = Provider.of<ExaminationInfoProvider>(context).examInfo; 
    print("Data in NavBar: $examInfo");  
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
            'assets/bottomNavBar/icon_alarm.svg',
            height: 30,
          ),
          label: 'Xác nhận lịch tái khám',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_checked.svg',
            height: 30,
          ),
          label: 'Duyệt thông tin tái khám',
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApprovedCalendarReExam(
                    examInfo: examInfo,
                        tenChuongTrinh: widget.tenChuongTrinh
                      )),
            );
            break;
          case 2:
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
