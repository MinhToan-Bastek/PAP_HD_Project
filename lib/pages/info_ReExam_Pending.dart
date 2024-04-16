import 'package:flutter/material.dart';
import 'package:pap_hd/components/bottomNavBar/approved_ReExamBottomNav.dart';
import 'package:pap_hd/components/info_ReExam_Pending/attachedReExam_pending.dart';
import 'package:pap_hd/components/info_ReExam_Pending/attachmentSection_pending.dart';
import 'package:pap_hd/components/info_ReExam_Pending/info_reExam_Body_pending.dart';
import 'package:pap_hd/components/info_ReExam_Pending/searchBar_ReExam.dart';
import 'package:pap_hd/components/info_ReExam_Pending/title_ReExam.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/update_info/attached_update.dart';
import 'package:pap_hd/components/update_info/update_info_body.dart';

class InfoReExamPending extends StatefulWidget {
   final int idPhieuTaiKham;  
  final String username;

  const InfoReExamPending({super.key, required this.idPhieuTaiKham, required this.username});  
  @override
  State<InfoReExamPending> createState() => _InfoReExamPendingState();
}

class _InfoReExamPendingState extends State<InfoReExamPending> {
  @override
void initState() {
    super.initState();
    print("Id Phiếu tái khám : ${widget.idPhieuTaiKham} và username: ${widget.username}");
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
                        InfoReExamBodyPen(username: widget.username, idPhieuTaiKham: widget.idPhieuTaiKham,),                      
                       AttachedPendingReExam(username: widget.username, idPhieuTaiKham: widget.idPhieuTaiKham,),
                       AttachmentSectionReExamPen(username: widget.username, idPhieuTaiKham: widget.idPhieuTaiKham,),
                        
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
