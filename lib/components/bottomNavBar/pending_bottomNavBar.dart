import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/details.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:pap_hd/pages/patient_searchApproved.dart';
import 'package:pap_hd/services/api_service.dart';

class CustomBottomNavBarPending extends StatefulWidget {
   final Map<String, dynamic>? patientDetail;
    final String username;
    final String id;
    final String pid;
    final String name;
    final String tenChuongTrinh;
  const CustomBottomNavBarPending({super.key, this.patientDetail,required this.username, required this.id,required this.pid, required this.name, required this.tenChuongTrinh});
  @override
  State<CustomBottomNavBarPending> createState() => _CustomBottomNavBarPendingState();
}

class _CustomBottomNavBarPendingState extends State<CustomBottomNavBarPending> {

  void _approvePatient() async {
  if (widget.patientDetail != null) {
    final apiService = ApiService();
    final id = int.parse(widget.id);
    final username = widget.username; 
    final status = 1; 

    final success = await apiService.approvePatient(username, id, status);
    
    if (success) {
     
     
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DetailScreen(pid: widget.pid, username: widget.username, name: widget.name,tenChuongTrinh: widget.tenChuongTrinh,)),
      );
    } else {
     
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Có lỗi xảy ra khi duyệt bệnh nhân!')));
    }
  }
}

//   void _approvePatient() async {
//   if (widget.patientDetail != null) {
//     final apiService = ApiService();
//     final id = int.parse(widget.id);
//     final username = widget.username; 
//     final status = 1;

//     final success = await apiService.approvePatient(username, id, status);
    
//     if (success) {
     
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => DetailScreen(pid: widget.pid, username: widget.username)),
//       );
//     } else {
//       // Hiển thị thông báo lỗi
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Có lỗi xảy ra khi duyệt bệnh nhân!')));
//     }
//   }
// }


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
            'assets/bottomNavBar/icon_check.svg',
            height: 30,
          ),
          label: 'Duyệt bệnh nhân',
        ),
        
      ],
      selectedItemColor: Colors.black, 
      unselectedItemColor: Colors.black, 
      selectedLabelStyle: TextStyle(fontSize: 8),
      unselectedLabelStyle: TextStyle(fontSize: 8),
      // Đặt index hiện tại để hỗ trợ highlighting item hiện tại, nếu cần
      currentIndex: 0, // Trang chủ được chọn mặc định
     onTap: (index) async {
  switch (index) {
    case 0:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
      break;
    case 1:
      // Hiển thị AlertDialog để xác nhận việc duyệt
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Duyệt bệnh nhân"),
          content: Text("Bạn có chắc chắn muốn duyệt bệnh nhân này không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
  // Đóng AlertDialog ngay lập tức
  Navigator.of(context).pop();

  // Sau đó gọi phương thức duyệt
  _approvePatient();
},

              child: Text('Duyệt'),
            ),
          ],
        ),
      );
      break;
  }
},

    );
  }
}
