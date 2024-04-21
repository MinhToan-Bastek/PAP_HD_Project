import 'package:flutter/material.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/attached_Calendar.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/body_Calendar_ReExam.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/searchBarApproved_ReExam.dart';
import 'package:pap_hd/components/approved_Calendar_ReExam/title_approvedReExam.dart';
import 'package:pap_hd/components/bottomNavBar/approved_ReExamBottomNav.dart';
import 'package:pap_hd/components/bottomNavBar/calendar_approved_bottomNav.dart';
import 'package:pap_hd/components/info_ReExam_Pending/searchBar_ReExam.dart';
import 'package:pap_hd/components/info_ReExam_Pending/title_ReExam.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/update_info/attached_update.dart';
import 'package:pap_hd/components/update_info/update_info_body.dart';

class ApprovedCalendarReExam extends StatefulWidget {
  final String tenChuongTrinh;
  final Map<String, dynamic> examInfo;
  const ApprovedCalendarReExam(
      {super.key, required this.tenChuongTrinh, required this.examInfo});

  @override
  State<ApprovedCalendarReExam> createState() => _ApprovedCalendarReExamState();
}

class _ApprovedCalendarReExamState extends State<ApprovedCalendarReExam> {
  final GlobalKey<CalendarReExamBodyState> formKey =
      GlobalKey<CalendarReExamBodyState>();

  bool _isToggleOn = false;
  // Phương thức để cập nhật trạng thái hiển thị của các widget
  void _updateToggleStatus(bool isOn) {
    setState(() {
      _isToggleOn = isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Exam Info Data: ${widget.examInfo}");
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
              TitleCalendarReExam(
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
                        SearchBarCalendarReExam(),
                        CalendarReExamBody(
                          onToggle: _updateToggleStatus,
                          examInfo: widget.examInfo,
                           key: formKey,
                        ),

                        if (_isToggleOn) ...[
                          AttachmentSection(),
                          AttachedCalendar(),
                          //AttachmentSection(),
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
      bottomNavigationBar: CalendarBottomNavBarApproved(
        formKey: formKey, // Sử dụng GlobalKey đã khởi tạo ở trên
        onSavePressed: () {
          if (formKey.currentState != null) {
            formKey.currentState!.createAlertExamination();
          }}
      ),
    );
  }
}
