import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/adverse_reporting.dart';
import 'package:pap_hd/pages/adverse_status.dart';
import 'package:pap_hd/pages/approved_calendarReExam.dart';
import 'package:pap_hd/pages/patient_registration.dart';

class OptionsGrid extends StatelessWidget {
    final String maChuongTrinh;
     final String username; 
      OptionsGrid({Key? key, required this.maChuongTrinh, required this.username}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    final options = [
      {'icon': 'assets/detailScreen/icon_work.svg', 'label': 'Tình trạng công việc'},
      {'icon': 'assets/detailScreen/icon_patient.svg', 'label': 'Đăng ký bệnh nhân','screen': PatientRegistScreen(maChuongTrinh: maChuongTrinh,username:username)},
      {'icon': 'assets/detailScreen/icon_approved.svg', 'label': 'Xác nhận lịch tái khám','screen': ApprovedCalendarReExam()},
      {'icon': 'assets/detailScreen/icon_support.svg', 'label': 'Cập nhật thông tin hỗ trợ'},
      {'icon': 'assets/detailScreen/icon_reportbl.svg', 'label': 'Báo cáo biến cố bất lợi','screen': AdverseReporting()},
      {
        'icon': 'assets/detailScreen/icon_infopati.svg',
        'label': 'Thông báo bệnh nhân ngừng chương trình',
      },
      {'icon': 'assets/detailScreen/icon_rpmedicine.svg', 'label': 'Báo cáo kiểm tra thuốc'},
      {'icon': 'assets/detailScreen/icon_rpmedicine.svg', 'label': 'Tình trạng báo cáo biến cố bất lợi','screen': AdverseStatus()},
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: 380.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFE0F2EF),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: options.length,
       itemBuilder: (context, index) {
  return InkWell(
    onTap: () {
      var screen = options[index]['screen'];
      if (screen is Function) {
        // Nếu 'screen' là một hàm, gọi hàm đó để tạo instance mới
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen()),
        );
      } else {
        // Nếu 'screen' không phải là một hàm, tiếp tục điều hướng như bình thường
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen as Widget),
        );
      }
      print("${options[index]['label']} pressed");
    },
    child: OptionItem(
      iconAsset: options[index]['icon'] as String,
      label: options[index]['label'] as String,
    ),
  );
},

      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String iconAsset;
  final String label;

  const OptionItem({Key? key, required this.iconAsset, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgPicture.asset(
          iconAsset,
          height: 30.0,
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
