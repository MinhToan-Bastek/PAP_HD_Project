import 'package:flutter/material.dart';
import 'package:pap_hd/components/adverse_reporting/attached_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting/body_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting/searchBar_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting/title_adverse_Reporting.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/attached_Calendar.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/body_Calendar_ReExam.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/searchBarApproved_ReExam.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/title_approvedReExam.dart';
import 'package:pap_hd/components/bottomNavBar/adverse_reportNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/approved_ReExamBottomNav.dart';
import 'package:pap_hd/components/bottomNavBar/calendar_approved_bottomNav.dart';
import 'package:pap_hd/components/info_ReExam_Pending/searchBar_ReExam.dart';
import 'package:pap_hd/components/info_ReExam_Pending/title_ReExam.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/update_info/attached_update.dart';
import 'package:pap_hd/components/update_info/update_info_body.dart';

class AdverseReporting extends StatefulWidget {
  final String tenChuongTrinh;
  final Map<String, dynamic> patientDetail;
  final String username;
  const AdverseReporting(
      {super.key,
      required this.tenChuongTrinh,
      required this.patientDetail,
      required this.username});

  @override
  State<AdverseReporting> createState() => _AdverseReportingState();
}

class _AdverseReportingState extends State<AdverseReporting> {
  final GlobalKey<AdverseReportingBodyState> formKey =
      GlobalKey<AdverseReportingBodyState>();

  bool _isToggleOn = false;
  @override
  void initState() {
    super.initState();
    // In ra console khi widget được khởi tạo
    print('Patient Detail: ${widget.patientDetail}');
    print('Username: ${widget.username}');
    print('Tên chương trình: ${widget.tenChuongTrinh}');
  }

  // Phương thức để cập nhật trạng thái hiển thị của các widget
  void _updateToggleStatus(bool isOn) {
    setState(() {
      _isToggleOn = isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Ảnh nền cho toàn bộ màn hình
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homeScreen/home_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              TitleAdverseReport(
                tenChuongTrinh: widget.tenChuongTrinh,
              ), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //SearchBarAdverseReport(),
                        AdverseReportingBody(
                          onToggle: _updateToggleStatus,
                          patientDetail: widget.patientDetail,
                          username: widget.username,
                           key: formKey,
                        ),

                        if (_isToggleOn) ...[
                          AttachmentSection(),
                          AttachedReporting(),
                        ],

                        // Thêm các widget khác nếu cần
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AdverseReportNavBar(
        formKey: formKey, // Sử dụng GlobalKey đã khởi tạo ở trên
        onSavePressed: () {
          if (formKey.currentState != null) {
            formKey.currentState!.createADR();
          }}
      ),
    );
  }
}
