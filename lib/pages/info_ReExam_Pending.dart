import 'package:flutter/material.dart';
import 'package:pap_hd/components/bottomNavBar/approved_ReExamBottomNav.dart';
import 'package:pap_hd/components/info_ReExam_Pending/searchBar_ReExam.dart';
import 'package:pap_hd/components/info_ReExam_Pending/title_ReExam.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/update_info/attached_update.dart';
import 'package:pap_hd/components/update_info/update_info_body.dart';

class InfoReExamPending extends StatefulWidget {
  
  @override
  State<InfoReExamPending> createState() => _InfoReExamPendingState();
}

class _InfoReExamPendingState extends State<InfoReExamPending> {
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
              TitleReExam(), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        //SizedBox(height: 5),
                        SearchBarReExam(),
                        UpdateInfoBody(),
                        //MedicineForm(),
                        AttachmentSection(),
                        AttachedUpdate(),
                        AttachmentSection(),
                        //AttachedDocumentsSection(),
                         //AttachmentSection(),
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
      bottomNavigationBar: BottomNavBarReExam(),
    );
  }
  
}
