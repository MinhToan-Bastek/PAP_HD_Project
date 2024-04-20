import 'package:flutter/material.dart';
import 'package:pap_hd/components/adverse_reporting/attached_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting/body_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting/searchBar_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting/title_adverse_Reporting.dart';
import 'package:pap_hd/components/adverse_reporting_Detail/attachCheckbox.dart';
import 'package:pap_hd/components/adverse_reporting_Detail/attachment_sectionDetailReport.dart';
import 'package:pap_hd/components/adverse_reporting_Detail/body_adverse_reportDetail.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/attached_Calendar.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/body_Calendar_ReExam.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/searchBarApproved_ReExam.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/title_approvedReExam.dart';
import 'package:pap_hd/components/bottomNavBar/adverse_reportDetailNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/adverse_reportNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/approved_ReExamBottomNav.dart';
import 'package:pap_hd/components/bottomNavBar/calendar_approved_bottomNav.dart';
import 'package:pap_hd/components/info_ReExam_Pending/searchBar_ReExam.dart';
import 'package:pap_hd/components/info_ReExam_Pending/title_ReExam.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/update_info/attached_update.dart';
import 'package:pap_hd/components/update_info/update_info_body.dart';

class AdverseReportingDetail extends StatefulWidget {
  final String tenChuongTrinh;
  final Map<String, dynamic> reportDetail;
  final String username;
  const AdverseReportingDetail(
      {super.key,
      required this.tenChuongTrinh,
      required this.reportDetail,
      required this.username});

  @override
  State<AdverseReportingDetail> createState() => _AdverseReportingDetailState();
}

class _AdverseReportingDetailState extends State<AdverseReportingDetail> {

  bool _isToggleOn = true;
  @override
  void initState() {
    super.initState();
    // In ra console khi widget được khởi tạo
    print('Repoort Detail: ${widget.reportDetail}');
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
                        AdverseReportDetailBody(
                          onToggle: _updateToggleStatus,
                          reportDetail: widget.reportDetail,
                          username: widget.username,
                          
                        ),

                        if (_isToggleOn) ...[
                          AttachmentSectionRpDetail( reportDetail: widget.reportDetail,),
                          AttachmentChecklistRpDetail(reportDetail: widget.reportDetail),
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
      bottomNavigationBar: BottomNavBarReportDetail(
        
      ),
    );
  }
}
