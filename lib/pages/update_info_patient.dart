import 'package:flutter/material.dart';
import 'package:pap_hd/components/bottomNavBar/approved_bottomNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/pending_bottomNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/regist_bottomNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/update_infoReExamBottomNav.dart';
import 'package:pap_hd/components/patient_registration/attached_document.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:pap_hd/components/patient_registration/title_patientRegis.dart';
import 'package:pap_hd/components/patient_search/info_patientSearch.dart';
import 'package:pap_hd/components/patient_search/searchBar.dart';
import 'package:pap_hd/components/patient_search/search_approved/searchBarApproved.dart';
import 'package:pap_hd/components/patient_search/title_patientSearch.dart';
import 'package:pap_hd/components/update_info/attached_update.dart';
import 'package:pap_hd/components/update_info/attached_update_interact.dart';
import 'package:pap_hd/components/update_info/search_bar_update.dart';
import 'package:pap_hd/components/update_info/title_updatePatient.dart';
import 'package:pap_hd/components/update_info/update_info_body.dart';

class UpdateInfoPatient extends StatefulWidget {
  
  @override
  State<UpdateInfoPatient> createState() => _UpdateInfoPatientState();
}

class _UpdateInfoPatientState extends State<UpdateInfoPatient> {
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
              TitlePatientUpdate(), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [                      
                        SearchBarUpdate(),
                        UpdateInfoBody(),
                        AttachmentSection(),
                        AttachedUpdate(),
                        AttachmentSection(),
                        AttachedUpdateInteract(),
                       
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: UpdateBottomNavBarReExam(),
    );
  }
  
}
